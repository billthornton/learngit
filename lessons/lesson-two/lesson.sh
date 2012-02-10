# An important concept to understand in Git is branching. Branches allow you to take a snapshot of your current code and make changes in an isolated area.
# Branching in Git is very lightweight and it is good practice to create branches for every new features, no matter how small. The consesus with Git is to be commiting lots of small changes often. Where you may have done just a single large commit in other systems, in git you will usually create a branch for that change. 
#Doing commits within a branch keeps all the changes together, so they can be shared with other developers only when the changes are at a stable point. 
#You can even combine multiple commits in a branch into a single commit for easier review by other developers. 

## Scenario:
## In order to appeal to a younger audience, management have decided to rename their website from x to y. Thus they want you to change all occurences of the word 'x' with 'y'. A designer has also created a spiffy new logo for the new website name.
echo;cd /tmp/lessons/lesson-two/workspace
git clone /tmp/lessons/lesson-two/__repo__ __lesson_name__ #run_in_parent_folder
# Let's cd into this folder and look at what is inside
cd __lesson_name__ #run_in_parent_folder
ls
# Ok, so we have cloned a front page, a news listing and a contact form. Lets look inside one of the files
cat index.html
# By default in Git you are placed on a default branch named 'master' when you checkout or create a repository. It is recommended you only place changes that are complete, and ready to be uploaded, into the master branch.
# Let's create a new branch to do our work in. There are a few ways to create a new branch, the easiest is 'git checkout -b <branch-name>' which tells git to create a new branch, and switch us to using that branch.
git checkout -b site-rename
# You can see which branch we are currently in by using the command 'git branch' without any extra parameters. I would also recommend looking into scripts that keep your current branch displayed in the terminal (re-word this).
git branch
# This branch you have made is local to you, and has not yet been shared with any other developers.
# We want to make our first change to this file, so lets replace all instances of x with y using the sed command line tool.
# (sed is a linux tool that can do operations on lines in files, such a simple search and replace inside a set of files). This command specifies it should replace all occurences of x with y within our website
sed -i 's/sitename/newname/g' *.html
# We can see what changes this has made by running the git diff command
git diff
# The next step is to change the logo on our website. We could do this in the same commit, however if we changed our mind on the logo change, it would make it harder to undo later.
# So lets commit our last change. First we need to add our changes. Since there are a lot, it would not make sence to add each file individually. The 'git add -u' command adds all of our updated files to be committed.
git add -u
# You can now run 'git status' to see what we are about to commit, or just write the commit message
git commit -m "Renamed the website from x to y"
# Now to replace the image, lets copy over the existing one with the updated logo
cp logo-new.png logo.png
# And commit this change
git commit logo.png -m "Added new logo"
# Notice we were not required to run 'git add <file>' here. If we are just wanting to commit changes a single file that was already in the repository, this shortcut essentially adds the change before running the commit.
## Great. Now to make this a realistic scenario, lets imagine that management decided they did not want to change the name of the site for another month.
## This is fine. Because our commits were isolated on their own seperate branch, we may switch back to master and continue adding new features in the mean time.
## Ok, so it is a month later, and we are ready for the name change. But during the past month another developer has added a blog to the site. This blog refered to the site as x, so it also needs updating to y.
## Pulling in the changes from other branches is easy in git. First we want to update our master branch so it contains the new blog by switching to the master branch and updating master..
## The first step is done with the 'git checkout' command and specifying the branch name.
echo;git checkout master
echo;cp news.html blog.html;sed -i 's/news/blog/g' blog.html
echo;git add blog.html;git commit -m "Added a blog page to the site"
echo;git push origin master
echo;git checkout site-rename
git checkout master
# Let's pull down the latest changes from the master server (origin)
git pull
# So now we are updated, switch back to our 'site-rename' branch.
git checkout site-rename
# To pull in all the latest commits from master, we use the 'git merge <branch-name>' command, where branch name is the name of the branch we want to pull in.
git merge master
# Great so we have the latest changes.
# It is recommended you keep your branches as up to date as possible by merging the changes from master into your feature branch often. This means you are applying lots of small changes at constant intervals, rather than trying to apply massive amounts of changes at once which increases the likely hood of getting merge errors (conflicts).
# So, now lets re-do our search and replace on the new blog content
sed -i 's/sitename/newname/g' *.html
# and commit the changes
git add -u
git commit -m "Changed 'x' to 'y' in the blog"
# We may now show our changes to management, once they are happy with it, we may apply our changes to master ready to be uploaded to the live site. This is done just like how we pulled in the master changes into our branch. But this time, we are pulling in our renaming changes into the master branch.
# Git is clever enough to only pull across changes from our branch that are not already on the master branch.
# Let's switch to master, and merge our branch in
git checkout master
git merge site-rename
# We could now leave our site-rename branch alone, but since our work on it is done, we may as well delete it.
# This is done using the command 'git branch -d <branch-name>'. This command is clever enough to first make sure all of our commits have been merged into master before it will allow you to delete it.
git branch -d site-rename
# Great, that is all done. Now we just need to push these changes so our sys admin can see them.
# You saw the 'git push' command in lesson one, however this time we will use a slightly expanded version.
# Since we may be dealing with many branches, it is good practice to tell git what branch you are pushing, and where you are pushing it to in the format 'git push <location> <branch-name>'. In our case, 'git push origin master', which tells git to push our master branch to the origin server (the main repository).
git push origin master









# You decide you don't wish to rename your website yet, and wish to put of the work until late.
# 2 months later, you decide it is the right time to do the rename, but you have just added a blog to your website with copy mentioning 'x'!
