cd ../lessons/lesson-one/
# Create a fake repo that we can clone from
mkdir -p temp/__repo__
mkdir -p temp/workspace
cp files/* temp/__repo__/
cd temp/__repo__
git init
git add todo.txt
git commit -m "Initial commit of my todo list"
# Make the repo a bare repo (so we can push to it)
sed -i 's/bare = false/bare = true/g' ./.git/config
