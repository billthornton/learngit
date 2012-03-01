LESSON_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $LESSON_DIR
cd $LESSON_DIR

# Create a fake repo that we can clone from
LESSON_TEMP=`python -c "import os;print os.path.realpath(os.path.join('/tmp/lessons', os.path.basename(os.getcwd())))"`
echo $LESSON_TEMP

mkdir -p $LESSON_TEMP
cd $LESSON_TEMP
mkdir -p workspace/__lesson_name__
mkdir files
cp -R $LESSON_DIR/files $LESSON_TEMP/files
cd $LESSON_TEMP/workspace/__lesson_name__
git init
cp -R $LESSON_DIR/files/1/ $LESSON_TEMP/workspace/__lesson_name__
git add templates
git commit -m "Initial commit"

