# Stashing changes
# ================
# There are times when you are part-way though doing a set of changes, and you want to put them aside for a while. Git offers provides a 'stash' command, which allows you to put aside your changes until later.
# Note: If you are stashing changes often, it may be a symptom of not branching and committing often enough.
## Scenario:
## You are working on adding comments to the news section of a website when you come across a bug that is stopping the news page from loading. You ask the developer who created the news section, and he tells you he has just fixed that bug and pushed it to master after you started working on the comments.
## In order for you to pull down his changes, you need to do it on a clean environment (i.e. no modifications to any files).
## So let's place our changes aside by stashing them, it is good practice to give your stash a name so you remember it.
git stash save "Adding comments"
# We can see the stash has now been added to the list using the 'git stash list' command
git stash list
# We can now see the working directory is clean by running a 'git status'
git status
# So, let's now pull down the latest changes
git pull
# Great! So we see can see we have the fix for the news page by typing 'git log'
echo;git commit -m "Fixed an error on the news page"
git log
# So we now want to apply our stashed changes back into our codebase. Since we just added the stash we know it is the last one added, so we can pop it off the top of the list using 'git stash pop' 
git stash pop
# And you can see the changes have been re-applied for us to continue working
git status
# It is recommended you stash any changes you have on files, before pulling any changes, or moving between branches.
