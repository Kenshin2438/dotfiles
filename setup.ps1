param([switch] $WhatIf)

function LinkFiles([string]$Destination, [string]$Source) {
    Get-ChildItem -Path $Source | ForEach-Object {
        $linkPath = Join-Path -Path $Destination -ChildPath $_.Name
        $targetPath = $_.FullName

        if (Test-Path $linkPath) {
            Write-Warning "Destination already exists, skipping: $linkPath"
            return
        }

        if ($WhatIf) {
            New-Item -Path $linkPath -Type SymbolicLink -Target $targetPath -WhatIf
        } else {
            New-Item -Path $linkPath -Type SymbolicLink -Target $targetPath
            Write-Host "Linked: $name" -ForegroundColor Green
        }
    }
}

$REPO = $PSScriptRoot

function main {
    LinkFiles -Source "$REPO\.config"           -Destination "$HOME\.config"
    LinkFiles -Source "$REPO\AppData\Local"     -Destination "$HOME\AppData\Local"
    LinkFiles -Source "$REPO\AppData\Roaming"   -Destination "$HOME\AppData\Roaming"
    LinkFiles -Source "$REPO\Documents"         -Destination "$HOME\Documents" 
}

try {
    Push-Location $REPO
    main
} finally {
    Pop-Location
}
