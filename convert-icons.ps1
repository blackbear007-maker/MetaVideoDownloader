# Convert SVG icons to PNG format for Chrome Extension
# This script creates PNG icons with unified arrow design (F + T merged)

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

    # Background color (purple)
    $backgroundColor = [System.Drawing.Color]::FromArgb(102, 126, 234) # #667eea
    $graphics.Clear($backgroundColor)

    # White color for the arrow
    $whiteColor = [System.Drawing.Color]::White
    $pen = New-Object System.Drawing.Pen($whiteColor, [int]($Size * 0.06))

    # Calculate positions based on icon size
    $centerX = [int]($Size * 0.5)
    $tTopY = [int]($Size * 0.35)  # Arrow shaft starts at T top
    $bottomY = [int]($Size * 0.82)
    $arrowHeadY = [int]($Size * 0.68)
    $arrowWidth = [int]($Size * 0.12)

    # Draw central vertical line (arrow shaft) starting from T top
    $graphics.DrawLine($pen, $centerX, $tTopY, $centerX, $bottomY)

    # Draw arrow head (downward V) at bottom
    $arrowHeadPoints = @(
        [System.Drawing.Point]::new($centerX - $arrowWidth, $arrowHeadY),
        [System.Drawing.Point]::new($centerX, $bottomY),
        [System.Drawing.Point]::new($centerX + $arrowWidth, $arrowHeadY)
    )
    $graphics.DrawLines($pen, $arrowHeadPoints)

    # Draw T top bar (extend left from center)
    $tLeftX = [int]($Size * 0.35)
    $graphics.DrawLine($pen, $centerX, $tTopY, $tLeftX, $tTopY)  # T top bar (left from center)

    # Draw F horizontal bars (extend right from center)
    $fTopY = [int]($Size * 0.35)
    $fMidY = [int]($Size * 0.47)
    $fRightX = [int]($Size * 0.65)
    $graphics.DrawLine($pen, $centerX, $fTopY, $fRightX, $fTopY)  # F top bar (right from center)
    $graphics.DrawLine($pen, $centerX, $fMidY, $fRightX, $fMidY)  # F middle bar (right from center)

    # Save as PNG
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    # Cleanup
    $graphics.Dispose()
    $bitmap.Dispose()
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
