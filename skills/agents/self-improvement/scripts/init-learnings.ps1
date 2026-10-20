$learningDir = Join-Path (Get-Location) ".learnings"
New-Item -ItemType Directory -Force $learningDir | Out-Null

$files = @(
    @{
        Path    = Join-Path $learningDir "LEARNINGS.md"
        Header  = "# Learnings`n`nProject-specific corrections, best practices, and conventions worth keeping.`n"
    },
    @{
        Path    = Join-Path $learningDir "ERRORS.md"
        Header  = "# Errors`n`nNon-trivial failures, environment issues, and debugging notes.`n"
    },
    @{
        Path    = Join-Path $learningDir "FEATURE_REQUESTS.md"
        Header  = "# Feature Requests`n`nMissing capabilities that would be valuable to add later.`n"
    }
)

foreach ($file in $files) {
    if (-not (Test-Path $file.Path)) {
        Set-Content -Path $file.Path -Value $file.Header
    }
}

Write-Output "Initialized $learningDir"
