# Basic
## VirtualBox
```sh
sudo mount -t vboxsf E /mnt/E
```

## Add Source
Ubuntu 的软件源配置文件是 /etc/apt/sources.list。将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用 TUNA 的软件源镜像。

Ubuntu 18.04
```sh
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```

Ubuntu 16.04
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

## ShadowsocksR
```sh
# copy file to folder
 sudo chmod +x ./ssr 
 sudo ./ssr install
 sudo python ./select_config.py
 sudo ./ssr start
```

## git
```sh
# install
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
apt-get install git

# add key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
copy ~/.ssh/id_rsa.pub and add to git ssh

# show log
git log --graph --pretty=oneline --abbrev-commit --decorate
```

## fcitx-wbpy
```sh
sudo add-apt-repository ppa:fcitx-team/nightly # or sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
apply Chinese as global language and restart
```

## Modify Waiting Time(10s) for Ubuntu
```sh
sudo vim etc/default/grub
modify GRUB_HIDDEN_TIMEOUT= 3
sudo update-grub
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


# Vision & SLAM
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
install dependecy
```sh
sudo apt-get install libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb-dev libtbb2 libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev libdc1394-22-dev
```
cmake commond
```
-DCMAKE_BUILD_TYPE:STRING="Release" \
-DPYTHON3_PACKAGES_PATH:PATH="/home/jeffery/anaconda3/lib/python3.6/site-packages" \
-DPYTHON3_LIBRARY:FILEPATH="/home/jeffery/anaconda3/lib/libpython3.6m.so" \
-DBUILD_DOCS:BOOL="1" \
-DENABLE_CXX11:BOOL="1" \
-DPYTHON3_NUMPY_INCLUDE_DIRS:PATH="/home/jeffery/anaconda3/lib/python3.6/site-packages/numpy/core/include/numpy" \
-DPYTHON3_EXECUTABLE:FILEPATH="/home/jeffery/anaconda3/bin/python3" \
-DOPENCV_ENABLE_NONFREE:BOOL="1" \
-DPYTHON3_INCLUDE_DIR:PATH="/home/jeffery/anaconda3/include/python3.6m" \
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
apt-get install libflann-dev libusb-1.0-0-dev libudev-dev freeglut3-dev graphviz libpng16-dev libgtest-dev libxmu-dev libxi-dev libpcap-dev libqhull-dev
build vtk from source code
build pcl from source code
```

## g2o
in Ubuntu 14.04
```sh
download libQGLView
open libQGLView/QGLView/QGLView.pro with qt and build
cd /QGLView/build
sudo make install
build g2o

1. add line to ~/.bashrc
export LD_LIBRARY_PATH=/home/jeffery/Programs/Qt5.10.1/5.10.1/gcc_64/lib:$LD_LIBRARY_PATH
2. method 1 will affect other programs, so if want to run g2o app, open terminal
export LD_LIBRARY_PATH=/home/jeffery/Programs/Qt5.10.1/5.10.1/gcc_64/lib:$LD_LIBRARY_PATH
then
g2o_viewer
```
in Ubuntu 16.04
```sh
sudo apt-get install libQGLView-dev
cmake and build g2o
sudo make install
```

# Tools Installation & Setting
## Qt Creators
1. Environment/Keyboard
    ```
    ToggleModeSelector: Ctrl+Alt+0
    ```
1. Build & Run/General/build directory name:
    ```
    ./%{JS: Util.asciify("build-%{CurrentBuild:Name}")}
    ```
1. Build & Run/Kits/Enviroment:
    ```
    MAKEFLAGS=-j5
    ```
1. Beatifier/Clange Format: New Customerized Style “MyGoogle"
    ```sh
    BasedOnStyle: Google
    ColumnLimit: 120
    IndentWidth: 4
    AllowShortFunctionsOnASingleLine: true
    AllowShortIfStatementsOnASingleLine: true
    AllowShortLoopsOnASingleLine: true
    DerivePointerAlignment: false
    ```

## Latex
```sh
sudo apt-get install texlive-full
# texstudio
sudo apt-get install texstudio
```

# Deep Learning
