# Clean local repository
git fetch --prune
git remote prune origin
git gc --prune=all

# Delete remote deleted branches
git branch -r --merged | ForEach-Object { if ($_ -match "\->") { $_ -match "(?<remote>.+?)\/(?<branch>.+) ->" | Out-Null; $matches["remote"] + "/" + $matches["branch"] }else { $_ } } | ForEach-Object { if ($_ -notmatch "HEAD") { git push origin --delete $_ } }
