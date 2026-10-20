[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$ProjectRoot,
    [Parameter(Mandatory = $true)][string]$OutputZip,
    [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string[]]$IncludePath
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression

if (-not (Test-Path -LiteralPath $ProjectRoot -PathType Container)) { throw "Project directory missing: $ProjectRoot" }
$rootItem = Get-Item -LiteralPath $ProjectRoot -Force
if ($rootItem.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Links are not packaged: $($rootItem.FullName)" }
$root = [IO.Path]::GetFullPath($rootItem.FullName).TrimEnd('\', '/')
$rootPrefix = $root + [IO.Path]::DirectorySeparatorChar
$zipPath = [IO.Path]::GetFullPath($OutputZip)
if (-not $zipPath.EndsWith('.zip', [StringComparison]::OrdinalIgnoreCase)) { throw 'OutputZip must end in .zip' }
if ($zipPath.StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)) { throw 'OutputZip must be outside ProjectRoot' }
if (Test-Path -LiteralPath $zipPath) { throw "Output already exists: $zipPath" }
if (-not (Test-Path -LiteralPath (Split-Path $zipPath -Parent) -PathType Container)) { throw 'Output directory is missing' }

$files = [ordered]@{}
foreach ($requested in $IncludePath) {
    if ([IO.Path]::IsPathRooted($requested)) { throw "IncludePath must be relative: $requested" }
    $parts = @($requested -split '[\\/]' | Where-Object { $_ -ne '' })
    if ($parts.Count -eq 0 -or @($parts | Where-Object { $_ -eq '.' -or $_ -eq '..' }).Count -gt 0) { throw "Unsafe IncludePath: $requested" }
    $candidate = [IO.Path]::GetFullPath((Join-Path $root $requested))
    if (-not $candidate.StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)) { throw "IncludePath leaves project: $requested" }
    if (-not (Test-Path -LiteralPath $candidate)) { throw "IncludePath missing: $requested" }

    $cursor = $root
    foreach ($part in $parts) {
        $cursor = Join-Path $cursor $part
        $node = Get-Item -LiteralPath $cursor -Force
        if ($node.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Links are not packaged: $cursor" }
    }

    $selected = Get-Item -LiteralPath $candidate -Force
    if ($selected.PSIsContainer) {
        $pending = [System.Collections.Generic.Stack[string]]::new()
        $pending.Push($candidate)
        while ($pending.Count -gt 0) {
            $directory = $pending.Pop()
            $currentDirectory = Get-Item -LiteralPath $directory -Force
            if ($currentDirectory.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Links are not packaged: $directory" }
            foreach ($node in @(Get-ChildItem -LiteralPath $directory -Force)) {
                if ($node.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Links are not packaged: $($node.FullName)" }
                if ($node.PSIsContainer) {
                    $pending.Push($node.FullName)
                } else {
                    $relative = $node.FullName.Substring($rootPrefix.Length).Replace('\', '/')
                    $files[$relative] = $node.FullName
                }
            }
        }
    } else {
        $relative = $selected.FullName.Substring($rootPrefix.Length).Replace('\', '/')
        $files[$relative] = $selected.FullName
    }
}

if ($files.Count -eq 0) { throw 'No files selected' }
if ($files.Contains('__codex_package_manifest.json')) { throw 'Reserved manifest name selected' }

$entries = [System.Collections.Generic.List[object]]::new()
$stream = $null
$archive = $null
$createdOutput = $false
$complete = $false
try {
    try {
        $stream = [IO.File]::Open($zipPath, [IO.FileMode]::CreateNew)
        $createdOutput = $true
        $archive = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create, $false, [Text.Encoding]::UTF8)
        foreach ($relative in @($files.Keys | Sort-Object)) {
            $source = $files[$relative]
            $sourceNode = Get-Item -LiteralPath $source -Force
            if ($sourceNode.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw "Links are not packaged: $source" }
            $entry = $archive.CreateEntry($relative, [IO.Compression.CompressionLevel]::Optimal)
            $inputStream = [IO.File]::OpenRead($source)
            $entryStream = $entry.Open()
            $sha = [Security.Cryptography.SHA256]::Create()
            $hashingStream = [Security.Cryptography.CryptoStream]::new($entryStream, $sha, [Security.Cryptography.CryptoStreamMode]::Write)
            try {
                $inputStream.CopyTo($hashingStream)
                $hashingStream.FlushFinalBlock()
                $bytes = $inputStream.Position
                $digest = [BitConverter]::ToString($sha.Hash).Replace('-', '').ToLowerInvariant()
            }
            finally { $hashingStream.Dispose(); $inputStream.Dispose(); $sha.Dispose() }
            $entries.Add([ordered]@{
                path = $relative
                bytes = $bytes
                sha256 = $digest
            })
        }
        $manifest = [ordered]@{
            schema = 'codex-paper-delivery-v1'
            created_utc = [DateTime]::UtcNow.ToString('o')
            note = 'File inventory only; scientific claims and citations require separate review.'
            files = @($entries)
        }
        $manifestEntry = $archive.CreateEntry('__codex_package_manifest.json', [IO.Compression.CompressionLevel]::Optimal)
        $writer = [IO.StreamWriter]::new($manifestEntry.Open(), [Text.UTF8Encoding]::new($false))
        try { $writer.Write(($manifest | ConvertTo-Json -Depth 5)) }
        finally { $writer.Dispose() }
    }
    finally {
        try { if ($null -ne $archive) { $archive.Dispose() } }
        finally { if ($null -ne $stream) { $stream.Dispose() } }
    }

    # A complete write is not proof that the archive can be reopened or its payloads match.
    $readStream = [IO.File]::OpenRead($zipPath)
    $readArchive = $null
    try {
        $readArchive = [IO.Compression.ZipArchive]::new($readStream, [IO.Compression.ZipArchiveMode]::Read, $false, [Text.Encoding]::UTF8)
        if ($readArchive.Entries.Count -ne $files.Count + 1) { throw 'Package verification failed: entry count' }

        $archivePaths = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
        $manifestEntry = $null
        foreach ($entry in $readArchive.Entries) {
            if (-not $archivePaths.Add($entry.FullName)) { throw "Package verification failed: duplicate entry $($entry.FullName)" }
            if ($entry.FullName -ceq '__codex_package_manifest.json') { $manifestEntry = $entry }
        }
        if ($null -eq $manifestEntry) { throw 'Package verification failed: manifest missing' }

        $reader = [IO.StreamReader]::new($manifestEntry.Open(), [Text.Encoding]::UTF8)
        try { $savedManifest = $reader.ReadToEnd() | ConvertFrom-Json }
        finally { $reader.Dispose() }
        if ($savedManifest.schema -ne 'codex-paper-delivery-v1') { throw 'Package verification failed: manifest schema' }
        $manifestFiles = @($savedManifest.files)
        if ($manifestFiles.Count -ne $files.Count) { throw 'Package verification failed: manifest file count' }

        $manifestPaths = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
        foreach ($item in $manifestFiles) {
            $path = [string]$item.path
            if (-not $manifestPaths.Add($path)) { throw "Package verification failed: duplicate manifest path $path" }
            if (-not $files.Contains($path) -or -not $archivePaths.Contains($path)) { throw "Package verification failed: unexpected path $path" }
            if ($item.bytes -isnot [ValueType] -or [long]$item.bytes -lt 0) { throw "Package verification failed: invalid size for $path" }
            if ([string]$item.sha256 -cnotmatch '^[0-9a-f]{64}$') { throw "Package verification failed: invalid SHA-256 for $path" }

            $payload = $readArchive.GetEntry($path)
            $payloadStream = $payload.Open()
            $sha = [Security.Cryptography.SHA256]::Create()
            try {
                $buffer = New-Object byte[] 81920
                $actualBytes = [long]0
                while (($count = $payloadStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                    [void]$sha.TransformBlock($buffer, 0, $count, $buffer, 0)
                    $actualBytes += $count
                }
                [void]$sha.TransformFinalBlock([byte[]]::new(0), 0, 0)
                $actualHash = [BitConverter]::ToString($sha.Hash).Replace('-', '').ToLowerInvariant()
            }
            finally { $payloadStream.Dispose(); $sha.Dispose() }
            if ($actualBytes -ne [long]$item.bytes -or $payload.Length -ne [long]$item.bytes) { throw "Package verification failed: size mismatch for $path" }
            if ($actualHash -cne [string]$item.sha256) { throw "Package verification failed: SHA-256 mismatch for $path" }
        }
        foreach ($path in $files.Keys) {
            if (-not $manifestPaths.Contains($path)) { throw "Package verification failed: missing path $path" }
        }
    }
    finally {
        if ($null -ne $readArchive) { $readArchive.Dispose() }
        else { $readStream.Dispose() }
    }
    $complete = $true
}
finally {
    if (-not $complete -and $createdOutput -and
        (Test-Path -LiteralPath $zipPath -PathType Leaf)) {
        $cleanupTarget = Get-Item -LiteralPath $zipPath -Force
        if ([string]::Equals([IO.Path]::GetFullPath($cleanupTarget.FullName), $zipPath, [StringComparison]::OrdinalIgnoreCase) -and
            -not ($cleanupTarget.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            Remove-Item -LiteralPath $zipPath -Force
        }
    }
}

Write-Output "PACKAGE_OK files=$($files.Count) zip=$zipPath"
