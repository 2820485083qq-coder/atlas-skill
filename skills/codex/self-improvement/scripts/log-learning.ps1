param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("learning", "error", "feature")]
    [string]$Type,

    [Parameter(Mandatory = $true)]
    [string]$Summary,

    [ValidateSet("frontend", "backend", "infra", "tests", "docs", "config")]
    [string]$Area = "config",

    [ValidateSet("low", "medium", "high", "critical")]
    [string]$Priority = "medium",

    [ValidateSet("best_practice", "correction", "knowledge_gap", "workflow", "convention")]
    [string]$Category = "best_practice",

    [string]$Details = "",
    [string]$SuggestedAction = "",
    [string[]]$RelatedFiles = @(),
    [switch]$Preview
)

function Get-EntryId {
    param(
        [string]$Prefix,
        [string]$TargetFile
    )

    $today = Get-Date -Format "yyyyMMdd"
    $pattern = "## \[$Prefix-$today-"
    $count = 0

    if (Test-Path $TargetFile) {
        $matches = Select-String -Path $TargetFile -Pattern $pattern -SimpleMatch
        if ($matches) {
            $count = @($matches).Count
        }
    }

    return "{0}-{1}-{2:D3}" -f $Prefix, $today, ($count + 1)
}

function Join-FileList {
    param([string[]]$Items)

    if (-not $Items -or $Items.Count -eq 0) {
        return "none"
    }

    return ($Items -join ", ")
}

$learningDir = Join-Path (Get-Location) ".learnings"
New-Item -ItemType Directory -Force $learningDir | Out-Null

switch ($Type) {
    "learning" {
        $targetFile = Join-Path $learningDir "LEARNINGS.md"
        $prefix = "LRN"
        $entryId = Get-EntryId -Prefix $prefix -TargetFile $targetFile
        $body = @"
## [$entryId] $Category

**Logged**: $(Get-Date -Format s)
**Priority**: $Priority
**Status**: pending
**Area**: $Area

### Summary
$Summary

### Details
$(if ($Details) { $Details } else { "Add the context, correction, or pattern that is worth preserving." })

### Suggested Action
$(if ($SuggestedAction) { $SuggestedAction } else { "Add the follow-up or rule future work should apply." })

### Metadata
- Source: manual
- Related Files: $(Join-FileList -Items $RelatedFiles)

---
"@
    }
    "error" {
        $targetFile = Join-Path $learningDir "ERRORS.md"
        $prefix = "ERR"
        $entryId = Get-EntryId -Prefix $prefix -TargetFile $targetFile
        $body = @"
## [$entryId] error

**Logged**: $(Get-Date -Format s)
**Priority**: $Priority
**Status**: pending
**Area**: $Area

### Summary
$Summary

### Error
$(if ($Details) { $Details } else { "Add the failing command, stack trace, or unexpected output." })

### Suggested Fix
$(if ($SuggestedAction) { $SuggestedAction } else { "Add the most likely resolution or preventive step." })

### Metadata
- Reproducible: unknown
- Related Files: $(Join-FileList -Items $RelatedFiles)

---
"@
    }
    "feature" {
        $targetFile = Join-Path $learningDir "FEATURE_REQUESTS.md"
        $prefix = "FEAT"
        $entryId = Get-EntryId -Prefix $prefix -TargetFile $targetFile
        $body = @"
## [$entryId] feature_request

**Logged**: $(Get-Date -Format s)
**Priority**: $Priority
**Status**: pending
**Area**: $Area

### Requested Capability
$Summary

### User Context
$(if ($Details) { $Details } else { "Add why the capability matters and what problem it would solve." })

### Suggested Implementation
$(if ($SuggestedAction) { $SuggestedAction } else { "Add a likely implementation path or owning area." })

### Metadata
- Frequency: first_time
- Related Files: $(Join-FileList -Items $RelatedFiles)

---
"@
    }
}

if ($Preview) {
    Write-Output $body
    exit 0
}

if (-not (Test-Path $targetFile)) {
    Set-Content -Path $targetFile -Value "# $(Split-Path $targetFile -LeafBase)`n"
}

Add-Content -Path $targetFile -Value "`n$body"
Write-Output "Appended $entryId to $targetFile"
