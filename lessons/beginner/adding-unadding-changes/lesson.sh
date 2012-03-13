echo;cp -R /Users/billthornton/code/learngit/lessons/beginner/adding-unadding-changes/files/2/ /tmp/lessons/adding-unadding-changes/workspace/__lesson_name__
# Adding and unadding files to git
# ================================
# As mentioned in lesson one, to commit a change to a file in git, you must explicitly add that file to the staging area (known as the index) before it can be commited.
# You could commit each file individually by issuing a lot of 'git add path/to/file.ext' commands, however there are a number of easier shortcuts to make life easier.
## First, lets have a look at what is in our current repository
git status
# This shows us that there are three modified files, and one newly created file in our repository.
## Add all files
## -------------
## 'git add .' (alternativly 'git add --all')
## This will add to the index, all modified files AND all untracked files (files in your folder that have not yet been added to git)
git add .
# The git status command will show us what files have been added to our index.
git status
echo;git reset HEAD
## Add updated files
## -----------------
## Alternativly, if you just want to add the files you have made changes to, use the command 'git add -u' to add all updated files.
git add -u
git status
echo;git reset HEAD
# Here you can see only the files that are already tracked within git, and that have been modified will be committed
## It is good practice in git to not commit too much at once, and to instead commit a lot of small, but related, changes.
## Let's only add the changes that are in the <folder> folder. We can do this by just adding the shared path of these files
git add modules/blog
git status
echo;git reset HEAD
# It is important to understand that we are simply adding only the current changes to the staging area for for files we add. If we were to edit a file after we have called git add, that change will not be in the commit, unless we issue another 'git add' on the file.
##
## A powerful way of adding files is the make use of the * character. This is...
## This can be useful to only add files with a specific file extension
git add **/*.html
git status
## Undo the adding of a file
## -------------------------
## If you accidently add a file to the staging area, and do not want it in your commit, you can unstage it with the command 'git reset HEAD <file>'
## The head is...
## explain command..
git reset HEAD templates/base.html
# Now when we do a git status, we can see this file is no longer in the 'to be commited' section, but has moved down into the 'modified' section.
# This has not undone any changes to the file - the modifications are still there, they just won't be included in the next commit.
git status
