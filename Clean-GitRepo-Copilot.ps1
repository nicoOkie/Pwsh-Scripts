# Fetch and prune remote branches
git fetch --prune

# Delete local branches with no tracking reference
git branch -vv | Select-String -Pattern 'origin/.*: gone]' | ForEach-Object { $_.ToString().Split()[0] } | ForEach-Object { git branch -d $_ }