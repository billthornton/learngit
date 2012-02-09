cd ../lessons/lesson-one/
mkdir workspace
mkdir __repo__
cp files/* __repo__
cd __repo__
git init
git add todo.txt
git commit -m "Initial commit of my todo list"
# Make the repo a bare repo (so we can push to it)
sed -i 's/bare = false/bare = true/g' ./.git/config
