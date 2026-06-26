$published = "C:\02_Projects\01_Active_Projects\Writing-Lab\01_Blog\Posts\Published"
$site = "C:\02_Projects\01_Active_Projects\beyond-the-bedside"

# Copy all files from Published to site posts folder
Get-ChildItem "$published\*.md" | ForEach-Object {
    Copy-Item $_.FullName "$site\content\posts\$($_.Name)" -Force
}

Write-Host "Synced all posts → site"

Set-Location $site
git add content/posts/
git commit -m "sync: updated posts"
git push

Write-Host "Done. Site rebuilds in ~1 min."