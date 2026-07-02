# Convert SVG icons to PNG format for Chrome Extension
# This script creates simple PNG icons from the SVG designs

Add-Type -AssemblyName System.Drawing

function Create-PngIcon {
    param(
        [int]$Size,
        [string]$OutputPath
    )
    
    # Create bitmap
    $bitmap = New-Object System.Drawing.Bitmap $Size, $Size
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    
    # Background color (purple gradient-like solid color)
    $backgroundColor = [System.Drawing.Color]::FromArgb(102, 126, 234) # #667eea
    $graphics.Clear($backgroundColor)
    
    # Draw play button (white triangle)
    $margin = [int]($Size * 0.25)
    $playSize = $Size - (2 * $margin)
    
    # Triangle points
    $points = @(
        [System.Drawing.Point]::new($margin, $margin),
        [System.Drawing.Point]::new($Size - $margin, [int]($Size / 2)),
        [System.Drawing.Point]::new($margin, $Size - $margin)
    )
    
    $playColor = [System.Drawing.Color]::White
    $brush = New-Object System.Drawing.SolidBrush $playColor
    $graphics.FillPolygon($brush, $points)
    
    # Save as PNG
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    # Cleanup
    $graphics.Dispose()
    $bitmap.Dispose()
}

# Use current directory for icons
$scriptPath = $PSScriptRoot
$iconsDir = Join-Path $scriptPath "icons"

# Create icons directory if not exists
if (-not (Test-Path $iconsDir)) {
    New-Item -ItemType Directory -Path $iconsDir -Force | Out-Null
}

# Create PNG icons
Write-Host "Creating 16x16 icon..."
Create-PngIcon -Size 16 -OutputPath (Join-Path $iconsDir "icon16.png")

Write-Host "Creating 48x48 icon..."
Create-PngIcon -Size 48 -OutputPath (Join-Path $iconsDir "icon48.png")

Write-Host "Creating 128x128 icon..."
Create-PngIcon -Size 128 -OutputPath (Join-Path $iconsDir "icon128.png")

Write-Host "Icon conversion complete!"
