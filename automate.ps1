# ================================
# PowerShell Script: Full Folder HTML Generator
# Skips folders/files with 'average' or 'percentage' in name
# ================================

# Get all folders recursively, including current folder
$folders = Get-ChildItem -Directory -Recurse
$folders += Get-Item -Path "."

foreach ($folder in $folders) {

    # Skip folder if name contains 'average' or 'percentage' (case-insensitive)
    if ($folder.Name -match 'average|percentage') {
        Write-Host "Skipping folder: $($folder.FullName)"
        continue
    }

    $indexFile = Join-Path $folder.FullName "index.html"

    if (Test-Path $indexFile) {
        Write-Host "`nProcessing folder: $($folder.FullName)"

        # Read index.html content
        $htmlContent = Get-Content -Path $indexFile -Raw

        # Extract all href links
        $matches = [regex]::Matches($htmlContent, 'href="([^"]+)"')

        # Collect all unique filenames in this folder
        $allFiles = @()
        foreach ($match in $matches) {
            $fileName = $match.Groups[1].Value

            # Skip file if name contains 'average' or 'percentage'
            if ($fileName -match 'average|percentage') {
                Write-Host "Skipping file: $fileName"
                continue
            }

            if (-not $allFiles.Contains($fileName)) {
                $allFiles += $fileName
            }
        }

        # Loop through all files in the folder
        foreach ($fileName in $allFiles) {
            $filePath = Join-Path $folder.FullName $fileName

            if (-Not (Test-Path $filePath)) {
                $title = $fileName -replace '.html',''

                # Create HTML content with navigation to all files in folder
                $content = @"
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1.0'>
<title>$title</title>
<style>
body { font-family: Arial, sans-serif; line-height: 1.6; margin: 20px; background-color: #f9f9f9; color: #333; }
h1 { color: #0056b3; }
ul { list-style-type: none; padding-left: 0; }
li { margin-bottom: 6px; }
a { text-decoration: none; color: #007bff; }
a:hover { text-decoration: underline; }
</style>
</head>
<body>
<h1>$title</h1>
<p>Content for $title goes here.</p>
<h2>Navigate to other files:</h2>
<ul>
"@

                # Add links to all other files in the same folder
                foreach ($linkFile in $allFiles) {
                    $linkTitle = $linkFile -replace '.html',''
                    $content += "<li><a href='$linkFile'>$linkTitle</a></li>`n"
                }

                # Add back-to-index link
                $content += "<li><a href='index.html'>Back to Index</a></li>`n"

                $content += "</ul></body></html>"

                # Write file
                Set-Content -Path $filePath -Value $content
                Write-Host "Created file: $fileName"
            }
            else {
                Write-Host "File already exists: $fileName"
            }
        }
    }
}

Write-Host "`nAll folders processed. HTML files created with full navigation (excluding average/percentage)!"