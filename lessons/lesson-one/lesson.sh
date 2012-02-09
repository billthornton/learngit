# Learn Git
# =========
# Welcome to lesson one where we will be covering basic git workflow and common commands.
# 
# To complete this lesson, simply type in the next command. Using tab (or double space) will auto complete the command.
# At every step, there are a small selection of commands you may run (such as ls, git status, git log). To see the full list, type 'commands'
# 
## Scenario:
## A fellow developer, Jim, has created a git repository for us to keep track of a simple to-do list. We want to add a new item to this to-do list and share this change with him.
## To get started, we will checkout an existing repository using the 'git clone' command and specifying a remote server (refered to as 'origin')
git clone http://learngit.org/lesson-one.git
# Let's look at what this has done...
ls
# This has now cloned the git repository into a directory named 'lesson-one' (a custom folder name may be specified by passing it as an extra parameter)
# Let's cd into this folder and look at what is inside
cd __repo__
ls
# Ok, so we have a single file, lets see what is in there by by displaying the contents to the screen
cat todo.txt
# Great, a simple todo list. Lets add an item to this list by appending it to the bottom of the file
echo "learn git" >> todo.txt
# We can now see the changes to this file by using the 'git diff' command and specifying a filename
git diff todo.txt
# So, we are happy with this change and wish to commit it. Let's try the command 'git commit'
git commit
# But wait, that command didn't do anything?
# In git, changes you make must be added to a staging area called the 'index' before they can be committed. This helps provide you will full control over what changes are added in the commit. You may only add certain files, or even only a selection of changes in the file.
# We want to add all of the changes in our file, so we use the simplest form of 'git add <file>'.
git add todo.txt
# You can see an overview of the current state of the repository by running the 'git status' command.
git status
# You can see that this change is now listed under "Changes to be commited"
# We can now commit this change.
git commit -m "Added learning git to my todo list"
# Typing 'git log' will show our commit listed
git log
# We can look at what exactly this commit is by using the 'git show' command. Specific commits, branch names and tag names can also be passed as a second parameter.
git show
# With Git, a commit is only done to your local machine and is not automatically shared with the outside world. This allows you to do lots of small commits locally, and then only share them out with other developers when you decide to.
# To share the changes with our developer Jim, we must push the changes to our main repository (origin).
# We use the 'git push' command which will push all of our unshared commits.
git push
# Success! The next time Jim updates his repository he will receive our change from the main repository (origin).
