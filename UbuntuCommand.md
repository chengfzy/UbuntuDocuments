# Basic
## VirtualBox
```sh{.line-numbers}
sudo mount -t vboxsf E /mnt/E
```

## Add Source
Ubuntu 的软件源配置文件是 /etc/apt/sources.list。将系统自带的该文件做个备份，将该文件替换为下面内容，即可使用 TUNA 的软件源镜像。

Ubuntu 18.04
```sh{.line-numbers}
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
```sh{.line-numbers}
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
```sh{.line-numbers}
# copy file to folder
 sudo chmod +x ./ssr 
 sudo ./ssr install
 sudo python ./select_config.py
 sudo ./ssr start
```

## git
```sh{.line-numbers}
# install
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
apt-get install git

# add key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
copy ~/.ssh/id_rsa.pub and add to git ssh

# show log
git log --graph --pretty=oneline --abbrev-commit --decorate

# gc
git gc --prune=now
```

## fcitx-wbpy
```sh{.line-numbers}
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
apply Chinese as global language and restart
```

## Modify Waiting Time(10s) for Ubuntu
```sh{.line-numbers}
sudo vim etc/default/grub
modify GRUB_HIDDEN_TIMEOUT= 3
sudo update-grub
```

## 7z
```sh{.line-numbers}
sudo apt-get install p7zip
extract: 7z -x file.7z -r -o /home/folder
compress: 7z a -tr file.7z /home/folder/*
```

## tar, zip
```sh{.line-numbers}
tar -zxvf file.tar.gz
unzip archive_name.zip -d ./Folder
```

## bash
```sh{.line-numbers}
sudo apt-get install zsh
ehco $SHELL     # cureent used shell
cat /etc/shells # list shell
chsh -s /bin/zsh    # change to zsh

# install on-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# config
vim ~/.zshrc
# modify
ZSH_THEME="agnoster"
# Hide default user@hostname
DEFAULT_USER="jeffery"
# added by Anaconda3 installer
export PATH="/home/jeffery/anaconda3/bin:$PATH"

# install font
# download from https://github.com/powerline/fonts and install

# reboot
sudo reboot
```

## uGet and aria2
```sh{.line-numbers}
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo apt update
sudo apt install uget aria2
```


## CMake
```sh{.line-numbers}
sudo cp ./cmake-3.13.2-Linux-x86_64.sh /usr/local
sudo chmod +x /usr/local/cmake-3.13.2-Linux-x86_64.sh
sudo /usr/local/cmake-3.13.2-Linux-x86_64.sh
```
cmake configs

Name | find_packages  |    include_directories |   target_link_libraries
---|---|---|---
Eigen   |   Eigen3  |   EIGEN3_INCLUDE_DIR  |   |
Ceres   |   Ceres   |   CERES_INCLUDE_DIRS  |   CERES_LIBRARIES |
CSpare  |   CSParse |   CSPARSE_INCLUDE_DIR    |   CSPARSE_LIBRARY


## doxygen
```sh{.line-numbers}
sudo apt-get install doxygen
```

## Anaconda
```sh{.line-numbers}
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
# pytorch
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
# for legacy win-64
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/peterjc123/

source activate

# create common command
conda env -h
conda create --name py36 python=3.6
conda env list


# install local package
conda install --use-local pytorch-0.4.1-py37_cuda9.2.148_cudnn7.1.4_1.tar.bz2
```

## VS Code
install package:
C/C++, Code Spell Checker, Markdown Preview Enhanced, VSCode-Pandoc
```
setting:
{
    "markdown-preview-enhanced.usePandocParser": true,
    "markdown-preview-enhanced.mathRenderingOption": "MathJax",
    "markdown-preview-enhanced.previewTheme": "github-dark.css"
}
```


# Vision & SLAM
## Nvidia Driver
```sh{.line-numbers}
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
```sh{.line-numbers}
sudo apt-get install libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb-dev libtbb2 libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev libdc1394-22-dev
# used for python document
sudo apt-get install python-bs4 python3-bs4

# intel inference engine
source /opt/intel/computer_vision_sdk/bin/setupvars.sh
```
cmake commond
```sh{.line-numbers}
cmake \
-DCMAKE_BUILD_TYPE:STRING="Release" \
-DOPENCV_EXTRA_MODULES_PATH:PATH="../contrib/modules" \
-DPYTHON3_PACKAGES_PATH:PATH="/home/jeffery/anaconda3/lib/python3.6/site-packages" \
-DPYTHON3_LIBRARY:FILEPATH="/home/jeffery/anaconda3/lib/libpython3.6m.so" \
-DBUILD_DOCS=ON \ #-DENABLE_CXX11:BOOL="1" \
-DWITH_QT=ON  \
-DWITH_CUDA=ON \
-DWITH_INF_ENGINE=ON \
-DPYTHON3_NUMPY_INCLUDE_DIRS:PATH="/home/jeffery/anaconda3/lib/python3.6/site-packages/numpy/core/include" \
-DPYTHON3_EXECUTABLE:FILEPATH="/home/jeffery/anaconda3/bin/python3" \
-DOPENCV_ENABLE_NONFREE:BOOL="1" \
-DPYTHON3_INCLUDE_DIR:PATH="/home/jeffery/anaconda3/include/python3.6m" \
..
```
generate document
```sh{.line-numbers}
make -j4 doxygen
make install
```

## Sophus
```sh{.line-numbers}
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
```sh{.line-numbers}
sudo apt-get install libatlas-base-dev
sudo apt-get install libsuitesparse-dev
cmake ...
```

## Pangolin
```sh{.line-numbers}
# modify code in /src/display/device/display_x11.cpp, line 98-112
    int visual_attribs[] =
    {
        GLX_X_RENDERABLE    , True,
        GLX_DRAWABLE_TYPE   , GLX_WINDOW_BIT,
        GLX_RENDER_TYPE     , GLX_RGBA_BIT,
        GLX_X_VISUAL_TYPE   , GLX_TRUE_COLOR,
        GLX_RED_SIZE        , 8,
        GLX_GREEN_SIZE      , 8,
        GLX_BLUE_SIZE       , 8,
        GLX_ALPHA_SIZE      , 8,
        GLX_DEPTH_SIZE      , 24,
        GLX_STENCIL_SIZE    , 8,
        //GLX_DOUBLEBUFFER    , glx_doublebuffer ? True : False,
        GLX_DOUBLEBUFFER    , False,
        None
    };
# make and build
```

## Point Cloud Library
```sh{.line-numbers}
apt-get install libflann-dev libusb-1.0-0-dev libudev-dev freeglut3-dev graphviz libpng16-dev libgtest-dev libxmu-dev libxi-dev libpcap-dev libqhull-dev
build vtk(7.1.1) from source code
build pcl(1.8.1) from source code
```

## g2o
git checkout ff647b

in Ubuntu 14.04
```sh{.line-numbers}
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
```sh{.line-numbers}
sudo apt-get install libQGLView-dev
cmake and build g2o
sudo make install
```

# Tools Installation & Setting
## clang-format
1. clang format for file style and all project c++ files
    ```sh{.line-numbers}
    find . -regex '.*\.\(h\|hpp\|cpp\)' -exec clang-format-5.0 -style=file -i {} \;
    ```
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
    ```sh{.line-numbers}
    BasedOnStyle: Google
    ColumnLimit: 120
    IndentWidth: 4
    AllowShortFunctionsOnASingleLine: true
    AllowShortIfStatementsOnASingleLine: true
    AllowShortLoopsOnASingleLine: true
    DerivePointerAlignment: false
    ```
## Clion
1. Tools/External Tools/Add New
    - Name: ClangFormat
    - Program:
        ```
        /usr/bin/clang-format-5.0
        ```
    - Arguments:
        ```
        -style="{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 120}" -i $FileName$
        ```
    - Working directory: 
        ```
        $FileDir$
        ```
    - Add keyboard shortcut
        ```
        Ctrl+Shift+L
        ```


## Latex
```sh{.line-numbers}
sudo apt-get install texlive-full
# texstudio
sudo apt-get install texstudio
# pandoc
pandoc ./test.tex -s -o ./test.md
```

# Deep Learning
## CUDA and cuDNN
1. Remove old version
    ```sh{.line-numbers}
    sudo apt-get --purge remove libcudnn
    cd /usr/local/cuda-9.2/bin
    sudo ./uninstall_cuda_9.2.pl
    sudo apt-get autoremove
    ```
1. Install CUDA10.0
    ```sh{.line-numbers}
    # switch command mode using CTRL+ATL+F1
    sudo service lightdom stop
    sudo ./cuda_10.0.130_410.48_linux.run # don't install nvdia driver
    # add below code into ~/.zshrc
    # add CUDA path
    export PATH="/usr/local/cuda/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
    ```
1. Install cuDNN
    ```sh{.line-numbers}
    tar -xzvf cudnn-10.0-linux-x64-v7.4.1.5.tgz
    sudo cp cuda/include/cudnn.h /usr/local/cuda/include
    sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
    ```

## Pytorch
```sh{.line-numbers}
# CUDA 10.0
conda install pytorch torchvision cuda100 -c pytorch
```

## Tensorflow
Tensorflow doesn't support CUDA10.0 right now, should build from source
1. Install Bazel 0.18.1 bazed on [!Bazel install guide](https://docs.bazel.build/versions/master/install-ubuntu.html)
1. Git clone tensorflow
    ```sh{.line-numbers}
    git clone https://github.com/tensorflow/tensorflow.git
    cd ./tensorflow
    git checkout r1.12  # switch version 1.12
    ```
1. Configure
    ```sh{.line-numbers}
    ./configure
    # please use CUDA and set vesion 10.0, nccl version set to 1.3, others could be default
    ```
1. Build with CUDA, maybe slow
    ```sh{.line-numbers}
    bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
    ```
1. Ref:
    - https://www.tensorflow.org/install/source