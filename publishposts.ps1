param([string]$filename = "")

$ready     = "C:\02_Projects\01_Active_Projects\Writing-Lab\01_Blog\Posts\Ready"
$published = "C:\02_Projects\01_Active_Projects\Writing-Lab\01_Blog\Posts\Published"
$site      = "C:\02_Projects\01_Active_Projects\beyond-the-bedside"

if ($filename -eq "") {
    $files = Get-ChildItem "$ready\*.md"
    if ($files.Count -eq 0) {
        Write-Host "No files found in Ready folder."
        exit 1
    }
} else {
    $files = @(Get-Item "$ready\$filename")
    if (-not $files) {
        Write-Host "File not found in Ready: $filename"
        exit 1
    }
}

foreach ($file in $files) {
    $dest = "$site\content\posts\$($file.Name)"
    Copy-Item $file.FullName $dest
    Move-Item $file.FullName "$published\$($file.Name)"
    Write-Host "Published: $($file.Name)"
    Set-Location $site
    git add "content/posts/$($file.Name)"
}

git commit -m "publish: $($files.Count) post(s)"
git push

Write-Host "Done. Site rebuilds in ~1 min."