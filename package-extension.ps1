# Package the extension for Chrome Web Store.
# Uses the built-in bsdtar (Windows 10+) instead of Compress-Archive, because
# Compress-Archive on Windows PowerShell 5.1 writes backslash path separators
# (icons\icon16.png), which the Chrome Web Store cannot read.

$ErrorActionPreference = "Stop"
$scriptPath = $PSScriptRoot
$extensionName = "MetaVideoDownloader"

# Always use Windows' own bsdtar (not GNU tar from Git/MSYS, which cannot write ZIP)
$tarExe = Join-Path $env:SystemRoot "System32/tar.exe"
if (-not (Test-Path $tarExe)) { throw "bsdtar not found at $tarExe (requires Windows 10 1803+)" }

# Read version from manifest.json so the ZIP name never drifts
$manifest = Get-Content (Join-Path $scriptPath "manifest.json") -Raw -Encoding UTF8 | ConvertFrom-Json
$version = $manifest.version
$zipFileName = "${extensionName}_v${version}.zip"
$zipPath = Join-Path $scriptPath $zipFileName

# Files to include in the package (only what the extension needs at runtime)
$includeFiles = @(
    "manifest.json",
    "background.js",
    "content.js",
    "injected.js",
    "popup.html",
    "popup.js",
    "privacy.html",
    "icons/icon16.png",
    "icons/icon48.png",
    "icons/icon128.png"
)

foreach ($file in $includeFiles) {
    if (-not (Test-Path (Join-Path $scriptPath $file))) {
        throw "Required file not found: $file"
    }
}

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }

Push-Location $scriptPath
try {
    & $tarExe -a -cf $zipFileName @includeFiles
    if ($LASTEXITCODE -ne 0) { throw "tar failed with exit code $LASTEXITCODE" }
} finally {
    Pop-Location
}

Write-Host "Package created: $zipPath"
Write-Host "Package contents:"
& $tarExe -tf $zipPath | ForEach-Object { Write-Host "  $_" }
