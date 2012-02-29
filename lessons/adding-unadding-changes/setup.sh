cd ../lessons/adding-unadding-changes/
# Create a fake repo that we can clone from
mkdir -p /tmp/lessons/adding-unadding-changes/__repo__
mkdir -p /tmp/lessons/adding-unadding-changes/workspace
cp files/* /tmp/lessons/adding-unadding-changes/__repo__/
cd /tmp/lessons/adding-unadding-changes/__repo__
git init
git add *.html
git commit -m "Initial commit"
# Make the repo a bare repo (so we can push to it)
sed -i 's/bare = false/bare = true/g' ./.git/config

