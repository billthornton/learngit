# File deleting, moving and renaming
# 
# Much like telling git you wish to commit changes to a file by adding it to the staging ares, with deleting files you need to tell git you wish to delete that file. even if you delete a file from you operating system, you must run the 'git rm' command and commmit the delete.
# 
git rm file.ext
# here you can see we have two options, the -f command deletes the file in git, and deletes the file locally. The --cached command will delete the file only from git, leaving your local copy intact. thisbis useful if you...
# let's delete the file both locally and on git using -f
git rm -f file.ext
# Now we can see this delete operation is ready to be comitted.
git status
## With git, a rename operation is essencially both a delete operation and an add operation. Git is clever enough to identify that a file has been moved, even if there are some modifications to the file.
## lets rename our file to have a new file extension. Much like on linux, a rename of a file is done using the mv command.
git mv file.ext newfile.ext
# You can now see that the file is listed to be renamed.
git status
## To move a file, we use the same command, but specify the new path
mv file.ext newfolder/file.ext

