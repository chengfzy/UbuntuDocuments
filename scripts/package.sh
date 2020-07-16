#!/bin/bash
# Package Application with Linked Libraries
#
# Usage:
#   package [-a] APPLICATION [DESTINATION]
#
# 1. The `APPLICATION` is the application
# 2. The script will parse the application file name and regard it as application name
# 3. If don't input `DESTINATION`, then the default destination folder will be `<current folder>/package`
# 4. The destination folder will be the `DESTINATION/APPLICATION_NAME`
# 5. The application will put into `./bin` folder
# 6. The script will search the linked libraries, and package them put into `./lib` folder, the system libraries
#   (in folder `/usr/lib` or `/lib`) will be ignored.

# variables
app=""
des=$PWD/package
all_lib=0

function usage() {
    cat <<-EOT
    Usage: $0 [OPTIONS] APPLICATION [DESTINATION]
    
    Options:
        -a |all     Package all libraries
        -h |help    Display help message
    
    APPLICATION     Application file
    DESTINATION     Destination folder, the default is ./package
    
    Examples:
        Simple usage:        ./package.sh ./app
        Complicated usage:   ./package.sh -a ./app ./package_folder
EOT
}

while getopts ":ah" opt; do
    case $opt in
    a)
        all_lib=1
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    esac
done

shift $(($OPTIND - 1))

# parse application file
if [ -z $1 ]; then
    usage
    exit 1
else
    app=$1
fi

# parse destination folder
if [ $2 ]; then
    des=$2
fi

# check not input empty application file
if [ -z $app ]; then
    printf "Input empty application file\n\n"
    usage
    exit 1
fi

# parse options
name=$(awk -F/ '{print $NF}' <<<$app)
full_name=$(awk -F/ '{print $NF}' <<<$(realpath $app))
printf "========== Packing Application \"%s\" ==========\n" $name
printf "  App path: %s\n" $app
printf "  Destination: %s\n" $des
# search linked libs
if [ $all_lib == 1 ]; then
    printf "  Package all libraries\n"
    # (1) install all libraries
    libs=$(ldd $app | awk '{if (match($3,"/")) { printf("%s "),$3 } }')
else
    printf "  Package only local libraries\n"
    # (2) only install libraries not installed by `apt-get`
    libs=$(ldd $app | awk '{if (match($3,"/") && !match($3,"/usr/lib/") && !match($3,"/lib/x86_64")){ printf("%s "),$3 } }')
fi

# copy app and lib to des folder
printf '[1/2] Copy bins and libs...\n'
rm -rf $des
mkdir -p $des/$full_name/bin
mkdir -p $des/$full_name/lib
# copy bin and lib
cp $app $des/$full_name/bin
cp $libs $des/$full_name/lib
# add run.sh
echo "#!/bin/bash
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$PWD/lib
./bin/$name" >$des/$full_name/run.sh

# package to .tar.gz file
printf '[2/2] Package to %s.tar.gz...\n' $full_name
tar -czf $des/$full_name.tar.gz -C $des ./$full_name
