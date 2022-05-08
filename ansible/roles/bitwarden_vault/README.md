## just adds all files
## commit with commit messages

# add
git add .

# commit
read -p "Commit message: " commitMessage
git commit -m "$commitMessage"

# push
git push
