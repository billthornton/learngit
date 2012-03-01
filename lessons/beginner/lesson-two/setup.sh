cd ../lessons/lesson-two/
# Create a fake repo that we can clone from
mkdir -p /tmp/lessons/lesson-two/__repo__
mkdir -p /tmp/lessons/lesson-two/workspace
cp files/* /tmp/lessons/lesson-two/__repo__/
cd /tmp/lessons/lesson-two/__repo__
git init
git add index.html
git add logo.png
git commit -m "Intial commit"
git add news.html
git commit -m "Added news page"
git add contact.html
git commit -m "Added contact form"
# Make the repo a bare repo (so we can push to it)
sed -i 's/bare = false/bare = true/g' ./.git/config
