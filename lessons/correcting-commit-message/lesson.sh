# Changing the message of a local commit
# --------------------------------------
# (re-word) This
## ..you have just commited a new change, but realised you made a typo in the git message!
## Lets look a the latest log messages to see the one that is broken
git log
# Ok, so we want to change the commit message for the top commit. This is fine, as long as you have not yet run git push and shared this commit with anyone else.
# The easiest way to chage a commit message is the command 'git commit --ammend' which is a shortcut command to undo the whole commit, and then issue a new commit.
git commit --ammend -m "New commit message"
# We can now have a look at what this changed
git log
# Great, the change was successful
## Undoing and changing a local commit
## -----------------------------------
## But now what if we realised we actually made another mistake here, and commited a change to a file we didn't want?
## For that, we must undo the whole commit. For this we use the 'git reset' command.
## When doing a reset, you have two main options, you can do what is called a 'soft' reset, or a 'hard' reset.
## A soft reset is non-desctructive. In other words, you will never lose your modifications to a file, it will just undo the commit(s), but keep your changes ready to modify and commit again. For the reset of a single commit, it basically resets you back to just before you issued the 'git commit' command.
## A hard reset is destructive. It will permenantly delete your changes, resetting you back to before you even did the work. It will also delete any uncommited files, so be careful with this command. A hard reset can be undone however, which we will discuss later.
git reset --soft HEAD^
# explain ^ ...
# So let's look at where that has left us with the git status command
git status
# Great so this has taken us back to just before we did the 'git commit'
# Lets remove the change to <file> from our staging area (the index) so it is not going to be commited
git reset --HEAD file.txt
# (Optional) Run 'git status' here if you want to see where we are now at.
# So now we can do our git commit again
git commit -m "New commit message"

## Undoing an upstream commit
## --------------------------
## If you wish to remove a commit that has already been pushed, and shared with other developers, you must essencially do another commit that undoes the changes made in that commit
## This can be done with the 
