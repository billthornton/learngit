# To get a local copy of the repository we must first clone it from the
# remote server. 
git clone http://learngit.org/lesson-one.git
# Lets see what this has created
ls
# Now lets look at what is inside this folder
cd lesson-one
ls
# Ok, so we have a single file, lets look at what is inside
cat todo.txt
# Now lets add an extra step to the end of our todo list
echo "learn git" >> todo.txt
# We can now take a look at how this file is different from the one currently tracked in the repository.
git diff todo.txt
# So, we are happy with this change and wish to commit it
git commit
# We need to add our change ...
git add todo.txt
# We can now commit this change
git commit -m "Added learning git to my todo list"
# For the remote server to receive our changes, we must 
# This pushes all unpushed commits to the ``origin`` server
git push origin master
