# GitForge setup.ps1

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

$Folders = @(
    "$Root\scripts",
    "$Root\launchers",
    "$Root\config",
    "$Root\docs",
    "$Root\logs"
)

foreach ($Folder in $Folders) {
    New-Item -ItemType Directory -Force -Path $Folder | Out-Null
}

New-Item -ItemType File -Force -Path "$Root\logs\.gitkeep" | Out-Null

Write-Host ""
Write-Host "GitForge setup complete." -ForegroundColor Green
Write-Host ""
Write-Host "Run:"
Write-Host "  launchers\START_GITFORGE.bat"
Write-Host ""
