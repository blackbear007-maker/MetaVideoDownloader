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
    $topY = [int]($Size * 0.18)
    $bottomY = [int]($Size * 0.82)
    $arrowHeadY = [int]($Size * 0.68)
    $arrowWidth = [int]($Size * 0.12)

    # Draw central vertical line (arrow shaft)
    $graphics.DrawLine($pen, $centerX, $topY, $centerX, $bottomY)

    # Draw arrow head (downward V)
    $arrowHeadPoints = @(
        [System.Drawing.Point]::new($centerX - $arrowWidth, $arrowHeadY),
        [System.Drawing.Point]::new($centerX, $bottomY),
        [System.Drawing.Point]::new($centerX + $arrowWidth, $arrowHeadY)
    )
    $graphics.DrawLines($pen, $arrowHeadPoints)

    # Draw F shape on the left
    $fTopY = [int]($Size * 0.35)
    $fMidY = [int]($Size * 0.47)
    $fLeftX = [int]($Size * 0.35)
    $graphics.DrawLine($pen, $fLeftX, $fTopY, $centerX, $fTopY)  # F top bar
    $graphics.DrawLine($pen, $fLeftX, $fMidY, [int]($Size * 0.45), $fMidY)  # F middle bar

    # Draw T shape on the right
    $tTopY = [int]($Size * 0.35)
    $tRightX = [int]($Size * 0.65)
    $graphics.DrawLine($pen, $centerX, $tTopY, $tRightX, $tTopY)  # T top bar

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
