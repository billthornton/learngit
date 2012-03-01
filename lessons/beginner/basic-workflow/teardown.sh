LESSON_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $LESSON_DIR
cd $LESSON_DIR

# Create a fake repo that we can clone from
LESSON_TEMP=`python -c "import os;print os.path.realpath(os.path.join('/tmp/lessons', os.path.basename(os.getcwd())))"`
echo $LESSON_TEMP
rm -rf $LESSON_TEMP
