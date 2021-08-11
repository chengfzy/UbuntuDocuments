#!/bin/bash
# Some Configuration for Configure a New Ubuntu

# 0.0 Define some variables
user=jeffery:jeffery # user
# some folder
soft_folder=''
code_folder='/media/psf/Home/Documents/Code/RefCode'

# 0.1 Define usage function
function usage() {
    cat <<-EOT
   Usage: $0 SOFT_FOLDER [CODE_FOLDER]
    
    SOFT_FOLDER     Software folder
    CODE_FOLDER     Code folder, the default is "/media/psf/Home/Documents/Code/RefCode"

  Example:
       Simple usage:	sudo $0 /media/psf/Home/Downloads/Test /media/psf/Home/Documents/Code/RefCode
EOT
}

# 0.2. Define function to print title and subtitle
# print same characters
same_char() {
    for ((i = 0; i <= $1; i++)); do
        printf "$2"
    done
}
# section
section() {
    printf "\n"
    n=$(expr \( 80 - ${#1} \) / 2)
    # printf "=%.0s" {0..${x}}	# this function not avaliable for bash, only zsh
    same_char $n "="
    printf " %s " $1
    same_char $n "="
    printf "\n"
}
# sub section
sub_section() {
    printf "\n"
    n=$(expr \( 80 - ${#1} \) / 2)
    # printf "=%.0s" {0..${x}}	# this function not avaliable for bash, only zsh
    same_char $n "-"
    printf " %s " $1
    same_char $n "-"
    printf "\n"
}

# new line
newline() {
    printf "\n"
}

# 1. Define some variable
while getopts ":h" opt; do
    case $opt in
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

# parse soft folder
if [ -z $1 ]; then
    usage
    exit 1
else
    soft_folder=$1
fi

# parse code folder
if [ $2 ]; then
    code_folder=$2
fi

# check not input empty software folder
if [ -z $soft_folder ]; then
    printf "Input empty software folder\n\n"
    usage
    exit 1
fi

# check not input empty code folder
if [ -z $code_folder ]; then
    printf "Input empty code folder\n\n"
    usage
    exit 1
fi

section "Parse variable"
printf "Soft folder: \"%s\"\n" $soft_folder
printf "Code folder: \"%s\"\n" $code_folder

# 2. Start to configure
section "Install Tools and Libs"
m=1

# 2.x Set tsinghua source
sub_section "[2.$m] Set tsinghua source"
m=$(expr $m + 1)
sudo echo "# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse

# llvm
deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main
#deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main
" >/etc/apt/sources.list

# 2.x Remove other lib and apps
sub_section "[2.$m] Remove other libs and apps"
m=$(expr $m + 1)
sudo apt-get remove -y --purge libreoffice-* firefox
sudo apt-get autoremove

# 2.x Install git
sub_section "[2.$m] Install Git"
m=$(expr $m + 1)
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install -y git
# config
git config --global user.name "Jeffery Cheng"
git config --global user.email "chengcheng0829@gmail.com"
# generate key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -q -N "" -C "chengcheng0829@gmail.com"

# 2.x Install SSR
sub_section "[2.$m] Install SSR"
m=$(expr $m + 1)
printf 'SSR folder:\"%s\"\n' "$soft_folder/ShadowsocksR"
mkdir -p ~/Programs/ShadowsocksR
cp -rf $soft_folder/ShadowsocksR ~/Programs/
sudo chown $user -R ~/Programs
cd ~/Programs/ShadowsocksR
sudo chmod +x ./ssr
sudo ./ssr install
sudo cp ./Server01.config.json /home/jeffery/.local/share/shadowsocksr/config.json
sudo ./ssr start
# add link
mkdir ~/shell
sudo ln -s ~/Programs/ShadowsocksR/ssr ~/shell/ssr
sudo chown $user -R ~/shell

# 2.x Install fcitx
sub_section "[2.$m] Install fcitx"
m=$(expr $m + 1)
sudo add-apt-repository -y ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install -y fcitx-table-wbpy

# 2.x Install basic tools
sub_section "[2.$m] Install Basic Tools"
m=$(expr $m + 1)
sudo apt-get install -y p7zip trash-cli curl vim
# link for mac
sudo ln -s /media/psf/Home/Documents ~/MacDocuments

# 2.x Install zsh
sub_section "[2.$m] Install zsh"
m=$(expr $m + 1)
sudo apt-get install -y zsh
sudo chsh -s /bin/zsh # change to zshc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get install -y fonts-powerline
# config
sed -i 's/^ZSH_THEME=.*/ZSH_THEME=\"agnoster\"/' ~/.zshrc
sed -i 's/^# HIST_STAMPS=.*/HIST_STAMPS=\"yyyy-mm-dd\"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(git docker docker-compose)/' ~/.zshrc
echo "
# Hide default user
DEFAULT_USER="jeffery"

# modify rm command
alias rm=trash

# Add CUDA path
export PATH="/usr/local/cuda-10.1:\$PATH"
export PATH="/usr/local/cuda-10.1/bin:\$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-10.1:\$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64:\$LD_LIBRARY_PATH"

# Activate OpenVINO path
source /opt/intel/openvino/bin/setupvars.sh

# Add by Anaconda
export PATH="/home/jeffery/anaconda3/bin:\$PATH"

# Add ROS path
#source /opt/ros/melodic/setup.zsh
" >>~/.zshrc

# 2.x Install Chrome
sub_section "[2.$m] Install Chrome"
m=$(expr $m + 1)
file=$(find $soft_folder -maxdepth 1 -type f -name 'google-chrome*')
printf 'Chrome file:\"%s\"\n' "$file"
sudo dpkg -i $file

# 2.x Install VSCode
sub_section "[2.$m] Install VS Code"
m=$(expr $m + 1)
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
# sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt-get install -y apt-transport-https
# sudo apt-get update
# sudo apt-get install -y code
file=$(find $soft_folder -maxdepth 1 -type f -name 'code*')
printf 'VSCode file:\"%s\"\n' "$file"
sudo dpkg -i $file

# 2.x Install CMake
sub_section "[2.$m] Install CMake"
m=$(expr $m + 1)
cd $soft_folder
file=$(find ./ -maxdepth 1 -type f -name 'cmake*')
printf 'CMake file:\"%s\"\n' "$file"
sudo cp $file /usr/local
sudo chmod +x /usr/local/$file
cd /usr/local
sudo ./$file --skip-license
sudo rm -rf ./$file

# 2.x Install Anaconda
sub_section "[2.$m] Install Anaconda"
m=$(expr $m + 1)
cd $soft_folder
file=$(find ./ -maxdepth 1 -type f -name 'Anaconda*')
printf 'Anaconda file:\"%s\"\n' "$file"
sudo chmod +x $file
sudo $file -b
sudo chown $user -R ~/anaconda3

# 2.x Install basic library and tools
sub_section "[2.$m] Install Basic Programming Libs and Tools"
m=$(expr $m + 1)
sudo apt-get install -y build-essential qt5-default doxygen tree
sudo apt-get install -y libgoogle-glog-dev libgflags-dev libboost-all-dev
sudo apt-get install -y libsuitesparse-dev libtbb-dev nasm libatlas-base-dev
sudo apt-get install -y --allow-unauthenticated clangd clang-format

# 3. Build Libs
section "Build Libs"
m=1

# 3.x Build gtest
sub_section "[3.$m] Build googltest"
m=$(expr $m + 1)
file=$(find $code_folder/Others -maxdepth 1 -type f -name 'googletest*')
name=$(basename $file .tar.gz)
printf "googletest file:\"%s\", name: \"%s\"\n" $file $name
cd $code_folder/Others
rm -rf ./$name
tar -zxvf $file
cd ./$namels
mkdir build
cd ./build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release ..
make -j4
sudo make install
cd ..
cd ..
rm -rf $name

# 3.x Build Eigen
sub_section "[3.$m] Build Eigen"
m=$(expr $m + 1)
file=$(find $code_folder/Others -maxdepth 1 -type f -name 'eigen*')
name=$(basename "$file" .tar.gz)
printf 'Eigen file:\"%s\", name: \"%s\"\n' "$file" "$name"
cd $code_folder/Others
echo 'Install Eigen manually, input anykey when finish and go to next step'
read temp

# 3.x Build ceres
sub_section "[3.$m] Build ceres"
m=$(expr $m + 1)
file=$(find $code_folder/Others -maxdepth 1 -type f -name 'ceres*')
name=$(basename "$file" .tar.gz)
printf 'ceres file:\"%s\", name: \"%s\"\n' "$file" "$name"
cd $code_folder/Others
rm -rf ./$name
tar -zxvf $file
cd ./$name
mkdir mybuild
cd ./mybuild
cmake -DBUILD_TESTING=OFF -DCXX11=ON -DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF ..
make -j4
sudo make install
cd ..
cd ..
rm -rf $name

# 3.x Build Sophus
sub_section "[3.$m] Build Sophus"
m=$(expr $m + 1)
folder=$code_folder/Others/Sophus
printf 'Sophus folder:\"%s\"\n' $folder
cd $folder
mkdir build
cd ./build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ..
make -j4
sudo make install
cd ..
rm -rf ./build

# 3.x Build json
sub_section "[3.$m] Build json"
m=$(expr $m + 1)
file=$(find $code_folder/Others -maxdepth 1 -type f -name 'json*')
name=$(basename "$file" .tar.gz)
printf 'json file:\"%s\", name: \"%s\"\n' "$file" "$name"
cd $code_folder/Others
rm -rf ./$name
tar -zxvf $file
cd ./$name
mkdir build
cd ./build
cmake -DBUILD_TESTING=OFF -DCMAKE_BUILD_TYPE=Release ..
make -j4
sudo make install
cd ..
cd ..
rm -rf $name

# 3.x Build fmt
sub_section "[3.$m] Build fmt"
m=$(expr $m + 1)
file=$(find $code_folder/Others -maxdepth 1 -type f -name 'fmt*')
name=$(basename "$file" .tar.gz)
printf 'fmt file:\"%s\", name: \"%s\"\n' "$file" "$name"
cd $code_folder/Others
rm -rf ./$name
tar -zxvf $file
cd ./$name
mkdir build
cd ./build
cmake -DBUILD_SHARED_LIBS=ON -DFMT_TEST=OFF -DFMT_DOC=OFF ..
make -j4
sudo make install
cd ..
cd ..
rm -rf $name

# 3.x Build jpeg-turbo
sub_section "[3.$m] Build jpeg-turbo"
m=$(expr $m + 1)
file=$(find $code_folder/Vision -maxdepth 1 -type f -name 'libjpeg-turbo*')
name=$(basename "$file" .tar.gz)
printf 'jpeg-turbo file:\"%s\", name: \"%s\"\n' "$file" "$name"
cd $code_folder/Vision
rm -rf ./$name
tar -zxvf $file
cd ./$name
mkdir build
cd ./build
cmake -DWITH_JPEG7=ON -DWITH_JPEG8=ON -DCMAKE_INSTALL_PREFIX:PATH="/usr/local" -DCMAKE_INSTALL_LIBDIR:PATH="lib" \
    -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_MANDIR:PATH="<CMAKE_INSTALL_DATAROOTDIR>/man/jpeg-turbo" \
    -DCMAKE_INSTALL_DOCDIR:PATH="<CMAKE_INSTALL_DATAROOTDIR>/doc/jpeg-turbo" ..
make -j4
sudo make install
cd ..
cd ..
rm -rf $name

# 3.x Install OpenVINO
sub_section "[3.$m] Build OpenVINO"
m=$(expr $m + 1)
# rm -rf ./GPG-PUB-KEY-INTEL-OPENVINO-2020ßi
# wget https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020
# sudo apt-key add ./GPG-PUB-KEY-INTEL-OPENVINO-2020
# sudo touch /etc/apt/sources.list.d/openvino.list
# sudo echo "deb https://apt.repos.intel.com/openvino/2020 all main" > /etc/apt/sources.list.d/openvino.list
# sudo apt-get update
# rm -rf ./GPG-PUB-KEY-INTEL-OPENVINO-2020
echo 'Install OpenVINO manually, input anykey when finish and go to next step'
read temp

# 3.x Build OpenCV
sub_section "[3.$m] Build OpenCV"
m=$(expr $m + 1)
file=$(find $code_folder/Vision/OpenCV -maxdepth 1 -type f -name 'opencv-*')
name=$(basename "$file" .tar.gz)
file_contrib=$(find $code_folder/Vision/OpenCV -maxdepth 1 -type f -name 'opencv_contrib*')
name_contrib=$(basename "$file_contrib" .tar.gz)
file_cache=$(find $code_folder/Vision/OpenCV -maxdepth 1 -type f -name 'OpenCV4Cache*')
name_cache=$(basename "$file_cache" .tar.gz)
printf 'OpenCV file:\"%s\", name: \"%s\"\n' "$file" "$name"
printf 'OpenCV Contrib file:\"%s\", name: \"%s\"\n' "$file_contrib" "$name_contrib"
printf 'OpenCV Cache file:\"%s\", name: \"%s\"\n' "$file_cache" "$name_cache"
cd $code_folder/Vision/OpenCV
rm -rf $name
tar -zxvf $file
tar -zxvf $file_contrib
tar -zxvf $file_cache
mv $name_contrib $name/contrib
mv ./.cache $name/.cache
# install third lib
sudo apt-get install -y libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libavresample-dev libswscale-dev \
    libtbb-dev libtbb2 libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo apt-get install -y libfreetype6-dev libharfbuzz-dev
sudo apt-get install -y libhdf5-dev libtesseract-dev libleptonica-dev
sudo apt-get install -y python-bs4 python3-bs4
sudo apt-get install -y graphviz doxygen
cd ./$name
# modify doxygen setting in doc/Doxyfile.in
sed -i 's/^DOT_GRAPH_MAX_NODES.*/DOT_GRAPH_MAX_NODES=500/' ./doc/Doxyfile.in
mkdir build
cd ./build
# add intel inference engine
source /opt/intel/openvino/bin/setupvars.sh
# cmake commond: enable turbo-jpeg for performance
cmake \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DOPENCV_EXTRA_MODULES_PATH:PATH="../contrib/modules" \
    -DBUILD_DOCS=ON \
    -DWITH_QT=ON \
    -DWITH_CUDA=ON \
    -DCUDA_ARCH_BIN:STRING="7.5" \
    -DCUDA_64_BIT_DEVICE_CODE=ON \
    -DWITH_INF_ENGINE=ON \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DJPEG_INCLUDE_DIR:PATH="/usr/local/include" \
    -DJPEG_LIBRARY_RELEASE:FILEPATH="/usr/local/lib/libjpeg.so" \
    -DPYTHON3_PACKAGES_PATH:PATH="/home/jeffery/anaconda3/lib/python3.7/site-packages" \
    -DPYTHON3_LIBRARY:FILEPATH="/home/jeffery/anaconda3/lib/libpython3.7m.so" \
    -DPYTHON3_INCLUDE_DIR:PATH="/home/jeffery/anaconda3/include/python3.7m" \
    -DPYTHON3_NUMPY_INCLUDE_DIRS:PATH="/home/jeffery/anaconda3/lib/python3.7/site-packages/numpy/core/include" \
    -DPYTHON3_EXECUTABLE:FILEPATH="/home/jeffery/anaconda3/bin/python3" \
    -DOPENCV_ENABLE_NONFREE=ON \
    ..
make -j4
make -j4 doxygen
sudo make install
cd ..
cd ..
rm -rf $name

# 4.0 Update and upgrade all libs and tools
sub_section "[4.0] Update & Upgrade"
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get autoremove
