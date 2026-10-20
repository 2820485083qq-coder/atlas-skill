param(
    [switch]$Json
)

$configPath = Join-Path $env:APPDATA "obsidian/obsidian.json"

if (-not (Test-Path $configPath)) {
    Write-Error "Obsidian config not found at $configPath"
    exit 1
}

$raw = Get-Content $configPath -Raw
$config = $raw | ConvertFrom-Json

$vaultEntries = @()

if ($null -ne $config.vaults) {
    foreach ($property in $config.vaults.PSObject.Properties) {
        $value = $property.Value
        $lastOpened = $null

        if ($null -ne $value.ts) {
            try {
                $lastOpened = [DateTimeOffset]::FromUnixTimeMilliseconds([int64]$value.ts).ToLocalTime().ToString("yyyy-MM-dd HH:mm:ss")
            } catch {
                $lastOpened = "$($value.ts)"
            }
        }

        $vaultEntries += [pscustomobject]@{
            Id         = $property.Name
            Name       = Split-Path $value.path -Leaf
            Path       = $value.path
            Open       = [bool]$value.open
            LastOpened = $lastOpened
            CliEnabled = [bool]$config.cli
        }
    }
}

$vaultEntries = $vaultEntries | Sort-Object @{ Expression = "Open"; Descending = $true }, Name

if ($Json) {
    $vaultEntries | ConvertTo-Json -Depth 4
    exit 0
}

if (-not $vaultEntries) {
    Write-Output "No vaults found in $configPath"
    exit 0
}

$vaultEntries | Format-Table -AutoSize
