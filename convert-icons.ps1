# Convert SVG icons to PNG format for Chrome Extension
# This script creates PNG icons with F T download symbol design

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
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

    # Background color (purple)
    $backgroundColor = [System.Drawing.Color]::FromArgb(102, 126, 234) # #667eea
    $graphics.Clear($backgroundColor)

    # Calculate font size based on icon size
    $fontSize = [int]($Size * 0.35)
    $font = New-Object System.Drawing.Font("Arial", $fontSize, [System.Drawing.FontStyle]::Bold)

    # White color for text and symbols
    $whiteColor = [System.Drawing.Color]::White
    $brush = New-Object System.Drawing.SolidBrush $whiteColor
    $pen = New-Object System.Drawing.Pen($whiteColor, [int]($Size * 0.03))

    # Calculate positions
    $fX = [int]($Size * 0.22)
    $tX = [int]($Size * 0.68)
    $textY = [int]($Size * 0.65)

    # Draw F
    $graphics.DrawString("F", $font, $brush, $fX, $textY)

    # Draw download arrow in the middle
    $arrowCenterX = [int]($Size * 0.5)
    $arrowTopY = [int]($Size * 0.35)
    $arrowBottomY = [int]($Size * 0.75)
    $arrowWidth = [int]($Size * 0.12)

    # Arrow head (downward V)
    $arrowHeadPoints = @(
        [System.Drawing.Point]::new($arrowCenterX - $arrowWidth, $arrowTopY),
        [System.Drawing.Point]::new($arrowCenterX, $arrowTopY + $arrowWidth),
        [System.Drawing.Point]::new($arrowCenterX + $arrowWidth, $arrowTopY)
    )
    $graphics.DrawLines($pen, $arrowHeadPoints)

    # Arrow shaft (vertical line)
    $graphics.DrawLine($pen, $arrowCenterX, $arrowTopY + $arrowWidth, $arrowCenterX, $arrowBottomY)

    # Draw T
    $graphics.DrawString("T", $font, $brush, $tX, $textY)

    # Save as PNG
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    # Cleanup
    $graphics.Dispose()
    $bitmap.Dispose()
    $font.Dispose()
    $brush.Dispose()
    $pen.Dispose()
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
