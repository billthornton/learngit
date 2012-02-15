# Creating tags
# =============
# When, for example, you launch your website it is a good idea to 
# A tag in git, is basically just a nickname for a commit id. So instead of remembering commit '03811785fd9d22a49d4412d3c9395a17b945250d' you just need to remember 'version-1'. This makes it easier to go back to specific stable versions of your code. Say you just released a new update to your website and you find out some parts of the site are now broken. You can easily switch back to the previous version by switching to the previous tag, rolling back the changes that were made.
## So imagine we are just about to go live with a new verison of our website. Let's create a new tag for version two of the site
git tag version-2 -a -m "Tagged version two"
# You can now see the list of tags by just running the 'git tag' command
git tag
## But after not long, we start getting e-mails about problems with the site. People are getting errors when logging in an accessing x area of the site.
## To address these issues, we must first roll back to the previous, working, version.
git checkout version-1
# Detached head?
