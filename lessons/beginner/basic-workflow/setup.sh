LESSON_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $LESSON_DIR
# Create a fake repo that we can clone from
LESSON_TEMP="/tmp/lessons/$( dirname "${BASH_SOURCE[0]}" )"
LESSON_TEMP="$(readlink -f $LESSON_TEMP)"
echo $LESSON_TEMP

mkdir -p $LESSON_TEMP
cd $LESSON_TEMP
mkdir __repo__
mkdir -p workspace/__lesson_name__
cp -R $LESSON_DIR/files $LESSON_TEMP/__repo__
cd $LESSON_TEMP/__repo__
git init
git add todo.txt
git commit -m "Initial commit of my todo list"
# Make the repo a bare repo (so we can push to it)
sed -i '' -e 's/bare = false/bare = true/g' ./.git/config
