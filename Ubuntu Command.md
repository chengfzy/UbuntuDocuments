# Basic
## VirtualBox
```sh
sudo mount -t vboxsf E /mnt/E
```

## Add Source
Ubuntu 的软件源配置文件是 /etc/apt/sources.list。将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用 TUNA 的软件源镜像。
```sh
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
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
```

## Shadowsocks
```sh
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5
```

## fcitx-wbpy
```sh
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
apply Chinese as global language and restart
```

## 7z
```sh
sudo apt-get install p7zip
extract: 7z -x file.7z -r -o /home/folder
compress: 7z a -tr file.7z /home/folder/*
```

## tar, zip
```sh
tar -zxvf file.tar.gz
unzip archive_name.zip -d ./Folder
```

## git
```sh
apt-get install git
git log --graph --pretty=oneline --abbrev-commit --decorate
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
copy id_rsa.pub to git SSH
ssh -T git@github.com   # for test
```

## CMake
```sh
sudo apt-get install cmake-qt-gui
```
cmake configs

Name | find_packages  |    include_directories |   target_link_libraries
---|---|---|---
Eigen   |   Eigen3  |   EIGEN3_INCLUDE_DIR  |   |
Ceres   |   Ceres   |   CERES_INCLUDE_DIRS  |   CERES_LIBRARIES |
CSpare  |   CSParse |   CSPARSE_INCLUDE_DIR    |   CSPARSE_LIBRARY


## doxygen
```sh
sudo apt-get install doxygen
```

## Anaconda
```sh
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
source activate
```

## VS Code
install package:
C/C++, Code Spell Checker, Markdown Preview Enhanced, VSCode-Pandoc
```
setting:
{
    "markdown-preview-enhanced.usePandocParser": true,
    "markdown-preview-enhanced.mathRenderingOption": "MathJax",
    "markdown-preview-enhanced.previewTheme": "github-dark.css",
    "pandoc.pdfOptString": "--latex-engine=xelatex --template=D:/Programs/data/template.latex"
}
```


# Vision
## Nvidia Driver
```sh
sudo add-apt-repository ppa:graphics-drivers/ppa
...
We currently recommend: `nvidia-361`, Nvidia's current long lived branch.
For GeForce 8 and 9 series GPUs use `nvidia-340`
For GeForce 6 and 7 series GPUs use `nvidia-304`
...
sudo apt-get update
sudo apt-get install nvidia-384
sudo apt-get install mesa-common-dev
sudo apt-get install freeglut3-dev
```

## OpenCV
make, cannot use cmake-gui, will not generate python library
``` sh
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
[optional] sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
source activate
cmake \
-DCMAKE_CONFIGURATION_TYPES:STRING="Debug;Release" \
-DOPENCV_EXTRA_MODULES_PATH:PATH="/home/jeffery/Documents/Code/SourceCode/OpenCV/opencv-3.3.0/contrib/modules" \
-DBUILD_opencv_contrib_world:BOOL="1" \
-DBUILD_opencv_world:BOOL="1" \
-DBUILD_opencv_sfm:BOOL="0" \
-DOPENCV_ENABLE_NONFREE:BOOL="1" \
-DENABLE_CXX11:BOOL="1" \
-DBUILD_opencv_python2=OFF \
-DBUILD_opencv_python3=ON \
-DBUILD_TESTS:BOOL="0" \
-DBUILD_PERF_TESTS:BOOL="0" \
-DPYTHON3_EXECUTABLE:FILEPATH="/home/jeffery/Programs/anaconda3/bin/python3" \
-DPYTHON3_PACKAGES_PATH:PATH="/home/jeffery/Programs/anaconda3/lib/python3.6/site-packages" \
..
```
generate document
```sh
cd build/doc
make -j4 doxygen
make install
```

## Sophus
```sh
git clone https://github.com/strasdat/Sophus.git
cd Sophus
git checkout a621ff
mkdir build
cd build
cmake ..
make -j4
sudo make install
```

## Ceres
```sh
sudo apt-get install libatlas-base-dev
sudo apt-get install libsuitesparse-dev
cmake ...
```

## Point Cloud Library
```sh
apt-get install cmake g++   libboost1.58-all-dev libeigen3-dev libflann-dev python libusb-1.0-0-dev libudev-dev freeglut3-dev doxygen graphviz libpng12-dev libgtest-dev libxmu-dev libxi-dev libpcap-dev libqhull-dev
build vtk from source code
build pcl from source code
```

# Deep Learning
## Pytorch
```sh
export CMAKE_PREFIX_PATH=/home/jeffery/anaconda3/bin
const install cmake
conda install -c soumith magma-cuda80 # or magma-cuda75 if CUDA 7.5, only for GPU version
python setup.py install
```