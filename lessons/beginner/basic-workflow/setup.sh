cd ../lessons/lesson-one/
# Create a fake repo that we can clone from
mkdir -p /tmp/lessons/lesson-one/__repo__
mkdir -p /tmp/lessons/lesson-one/workspace
cp files/* /tmp/lessons/lesson-one/__repo__/
cd /tmp/lessons/lesson-one/__repo__
git init
git add todo.txt
git commit -m "Initial commit of my todo list"
# Make the repo a bare repo (so we can push to it)
sed -i 's/bare = false/bare = true/g' ./.git/config
