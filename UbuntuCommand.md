[TOC]



# Basic Setting
## Install Ubuntu
1. Use `Rufus` make UEFI bootloader in windows.
1. If reinstall ubuntu, choose `something else` during `Installation type`, and then select hardware and install.
1. Partition for ubuntu, 512M for EFI partition, 8-10G for swap, 80G ext4 partition for mounting `/`, others ext4 for mounting `/home`. Choose EFI partition for boot loader.

## Ubuntu Setting
1. `Setting/Keyboard`, search `switch`, and set the shortcut of `Switch windows` to `Super+Tab`.


## Add tsinghua Source
Modify `/etc/apt/sources.list`, see [tsinghua mirror](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/).

## Chrome
1. Install chrome.
    - Download in [ubuntu chrome](http://www.ubuntuchrome.com/)
    - Download [SwitchOmega](https://github.com/FelisCatus/SwitchyOmega/releases)
    - Modify `SwitchyOmega_Chromium.crx` to `SwitchyOmega_Chromium.zip`, and unzip to some folder.
    - Open `chrome://extensions/` in chrome, check developer mode, and `Load unpacked` from previous directory.
1. Install `Git`.
1. Install `ShadowSocks`, maybe should install `anaconda`
    ```sh{.line-numbers}
    # copy file to folder
    sudo chmod +x ./ssr 
    sudo ./ssr install
    sudo python3 ./select_config.py
    sudo ./ssr start
    ```
1. Log in `chrome` and synchronization
1. In ubuntu virtual system in `Parallels`, the chrome maybe show in white screen, add `--use-gl=angle` in file `/usr/share/applications/google-chrome.desktop` as below, modify there are 3 occurences.
    ```
    Exec=/usr/bin/google-chrome-stable --use-gl=angle
    ```


## GNOME Extension
1. ```sudo apt install chrome-gnome-shell```
1. Open [GNOME Shell integration for Chrome](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep) to install chrome extension
1. Open [GNOME Site](https://extensions.gnome.org/) to manage and set the extensions
1. Recommend extensions:
    - Hide Top Bar
    - Clipboard Indicator
    - Screenshot Tool


## proxy
Add below contents in `/etc/apt/apt.conf`
```sh{.line-numbers}
Acquire::http::proxy "http://10.69.60.221:8080";
Acquire::ftp::proxy "ftp://10.69.60.221:8080";
Acquire::https::proxy "https://10.69.60.221:8080";
```

Please use those commands before you use pip or wget to install anything.
```sh{.line-numbers}
export http_proxy="http://10.69.60.221:8080"
export https_proxy="http://10.69.60.221:8080"
```


## fcitx-wbpy
```sh{.line-numbers}
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx-table-wbpy
# apply Chinese as global language and restart
```


## 7z
```sh{.line-numbers}
sudo apt-get install p7zip
extract: 7z -x file.7z -r -o /home/folder
compress: 7z a -tr file.7z /home/folder/*
```

## tar, zip
```sh{.line-numbers}
tar -czf file.tar.gz ./folder
tar -zxvf file.tar.gz
unzip archive_name.zip -d ./Folder
```

## zsh
1. Install zsh
    ```sh{.line-numbers}
    sudo apt-get install zsh
    sudo apt-get install trash-cli  # trash
    ehco $SHELL     # cureent used shell
    cat /etc/shells # list shell
    chsh -s /bin/zsh    # change to zsh
    ```
1. Install [on-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
    ```sh{.line-numbers}
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ```
1. Config, modify `~/.zshrc` like below
    ```sh{.line-numbers}
    # Modify theme
    ZSH_THEME="agnoster"

    # Hide default user
    DEFAULT_USER="jeffery"

    # modify rm command
    alias rm=trash
    
    # added by Anaconda3 installer
    export PATH="/home/jeffery/anaconda3/bin:$PATH"
    ```
1. Install font
    - Download [powerline fonts](https://github.com/powerline/fonts) and install
    - Change font to 'Meslo' in teminal perference, also the scheme could be changed
1. Reboot


## uGet and aria2
```sh{.line-numbers}
sudo add-apt-repository ppa:plushuang-tw/uget-stable
sudo add-apt-repository ppa:uget-team/ppa
sudo apt update
sudo apt install uget aria2
sudo apt install uget-integrator    # for chrome integration
```


## Latex
```sh{.line-numbers}
sudo apt-get install texlive-full
# texstudio
sudo add-apt-repository ppa:sunderme/texstudio
sudo apt-get update
sudo apt-get install texstudio
# format
latexindent -w -s ./File.tex
# pandoc
pandoc ./test.tex -s -o ./test.md
```

## Zotero
1. Install based on the [offical instruction](https://www.zotero.org/support/installation#how_do_i_install_zotero)
1. Install plugin [better bibtex](https://retorque.re/zotero-better-bibtex/) ([download site](https://github.com/retorquere/zotero-better-bibtex/releases))
1. Modify config in `Preferences/Advanced/Config Editor`, search `rename`, and modify below value
    - `extensions.zotero.attachmentRenameFormatString`: `{%t{80}_}{%c_}{%y}`
    - `extensions.zotero.autoRenameFiles.linked`: `true`
    - `extensions.zotero.lastRenameAssociatedFile`: `true`
1. Log in and sync
1. Copy files in folder `storage` to this computer.

# Programming
## git
```sh{.line-numbers}
# install
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
apt-get install git

# user setting
git config --global user.name "Jeffery Cheng"
git config --global user.email "chengcheng0829@gmail.com"

# add key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
# copy ~/.ssh/id_rsa.pub and add to github ssh

# show log
git log --graph --pretty=oneline --abbrev-commit --decorate

# gc
git gc --prune=now

# proxy
git config --global http.proxy 'http://10.69.60.221:8080'
git config --global https.proxy 'https://10.69.60.221:8080'
```

## VS Code
1. Install `Settings Sync` extensions and synchronization


## Regex
```sh{.line-numbers}
# find any characters, include break line
[\s\S]*

# replace "=== xxxx ===" to section("xxx")
"=+ (.*) =+"  => section("$1")
```

## CMake
```sh{.line-numbers}
sudo cp ./cmake-3.13.2-Linux-x86_64.sh /usr/local
sudo chmod +x /usr/local/cmake-3.13.2-Linux-x86_64.sh
sudo /usr/local/cmake-3.13.2-Linux-x86_64.sh
```

## doxygen
```sh{.line-numbers}
sudo apt-get install doxygen
```

## Anaconda
1. Channels setting, see [tsinghua mirror](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)
```sh{.line-numbers}
# not be activated on startup
conda config --set auto_activate_base false

# add path to ~/.zshrc
export PATH="/home/jeffery/anaconda3/bin:$PATH"

source activate
# create common command
conda env -h
conda create --name py36 python=3.6
conda env list

# install local package
conda install --use-local pytorch-0.4.1-py37_cuda9.2.148_cudnn7.1.4_1.tar.bz2

# proxy
conda config --set proxy_servers.http http://10.69.60.221:8080
conda config --set proxy_servers.https https://10.69.60.221:8080
```


## NVIDA CUDA cuDNN
### Install NVIDA driver
1. Check the GPU info
    ```sh{.line-numbers}
    lspci | grep -i nvida
    ```
1. Disable nouveau
    add below text in `/etc/modprobe.d/blacklist.conf`
    ```sh{.line-numbers}
    blacklist vga16fb
    blacklist nouveau
    blacklist rivafb
    blacklist rivatv
    blacklist nvidiafb
    ```
1. Update kernel(I don't the why use this command, maybe it's unuseful)
    ```sh{.line-numbers}
    sudo update-initramfs -u
    ```
1. Reboot, input below command, if nothing ouput, then the disable nouveau is success.
    ```sh{.line-numbers}
    lsmod | grep nouveau
    ```
1. Add drivers repository
    ```sh{.line-numbers}
    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt-get update
    ```
1. Find recommand drivers using
    ```sh{.line-numbers}
    ubuntu-drivers devices
    ```
1. `Ctrl+Alt+F1` and close graphics,
    ```sh{.line-numbers}
    sudo service lightdm stop
    ```
1. Install driver
    ```sh{.line-numbers}
    sudo apt-get install nvidia-39
    ```
1. Reboot and check install is success
    ```sh{.line-numbers}
    nvidia-smi
    nvidia-settings
    ```

### Install CUDA
1. Download [CUDA](https://developer.nvidia.com/cuda-downloads), and install, and note don't install the driver
    ```sh{.line-numbers}
    sudo ./cuda_10.1.168_418.67_linux.run
    ```
1. Add CUDA path in `~/.zshrc`
    ```sh{.line-numbers}
    # Add CUDA path
    export PATH="/usr/local/cuda-10.1:$PATH"
    export PATH="/usr/local/cuda-10.1/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-10.1:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH"
    ```
1. Make `/usr/local/cuda/samples` and check install is success
    ```sh{.line-numbers}
    ./bin/x86_64/linux/release/deviceQuery
    ./bin/x86_64/linux/release/simpleTexture3D
    ```

### Install cuDNN
1. Download [cuDNN](https://developer.nvidia.com/rdp/cudnn-download) and install below deb
    - libcudnn7_7.6.2.24-1+cuda10.1_amd64.deb
    - libcudnn7-dev_7.6.2.24-1+cuda10.1_amd64.deb
    - libcudnn7-doc_7.6.2.24-1+cuda10.1_amd64.deb

### Reference
1. https://blog.csdn.net/u012253191/article/details/78997529
1. https://blog.csdn.net/qq_32408773/article/details/84112166


## SqliteBrowser
[Install Guide](https://sqlitebrowser.org/dl/)
```sh{.line-numbers}
sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser
sudo apt-get install sqlitebrowser
```


## Install Libraries
```sh{.line-numbers}
 sudo apt-get install libgoogle-glog-dev libgflags-dev libboost1.65-all-dev
 sudo apt-get install libsuitesparse-dev libtbb-dev nasm
 sudo apt-get install clang-format-8 qt5-default
```
Build source for below libraries
1. gtest
1. Eigen
1. ceres
1. Sophus
1. nlohmann json
1. yaml-cpp
1. SQLiteCpp
1. libjpeg-turbo-2.0.2, modify cmake setting
    - select `WITH_JPEG7`
    - select `WITH_JPEG8`
    - `CMAKE_INSTALL_PREFIX` to `/usr/local`
    - `CMAKE_INSTALL_LIBDIR` to `lib`
    - `CMAKE_INSTALL_DOCDIR` to `<CMAKE_INSTALL_DATAROOTDIR>/doc/turbojpeg`

## Tools Installation & Setting
### clang-format
1. clang format for file style and all project c++ files
    ```sh{.line-numbers}
    find . -regex '.*\.\(h\|hpp\|cpp\)' -exec clang-format-5.0 -style=file -i {} \;
    find . -regex '.*\.\(h\|hpp\|cpp\)' -exec clang-format-6.0 -style="{BasedOnStyle: Google, IndentWidth: 4, DerivePointerAlignment: false, AccessModifierOffset: -2, ColumnLimit: 120}" -i {} \;
    ```
### Qt Creators
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
    AccessModifierOffset: -2
    AllowShortFunctionsOnASingleLine: true
    AllowShortIfStatementsOnASingleLine: true
    AllowShortLoopsOnASingleLine: true
    DerivePointerAlignment: false
    ```
### Clion
1. Add plugin: `Fil Watchers` and Restart
1. Open setting `Tools/File Watchers`
1. New `<customered>`
    - Name: `Clang Format`
    - File type: `C/C++`
    - Scope: `Open Files`
    - Program: `/usr/bin/clang-format`
    - Arguments: `-style="{BasedOnStyle: Google, ColumnLimit: 120, IndentWidth: 4, DerivePointerAlignment: false, AccessModifierOffset: -2}" -i $FileName$`
    - Output paths t refresh: `$FileName$` 
    - Working directory: `$FileDir$`

# Vision & SLAM
## OpenVINO
1. Uncheck `OpenCV` and `OpenVX` during installation
1. Add path to `~/.zshrc`
    ```sh{.line-numbers}
    # Add OpenVINO path
    source /opt/intel/openvino/bin/setupvars.sh
    ```

## OpenCV
```sh{.line-numbers}
# install dependecy
sudo apt-get install libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libavresample-dev libswscale-dev libtbb-dev libtbb2 libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
# freetype
sudo apt-get install libfreetype6-dev libharfbuzz-dev
# others modules dependency
sudo apt-get install libhdf5-dev libtesseract-dev libleptonica-dev

# used for python document
sudo apt-get install python-bs4 python3-bs4
# used for svg document
sudo apt-get install graphviz doxygen
# modify doxygen setting in doc/Doxyfile.in
DOT_GRAPH_MAX_NODES = 500

# add intel inference engine
source /opt/intel/openvino/bin/setupvars.sh


# cmake commond: enable turbo-jpeg for performance
cmake \
-DCMAKE_BUILD_TYPE:STRING="Release" \
-DOPENCV_EXTRA_MODULES_PATH:PATH="../contrib/modules" \
-DBUILD_DOCS=ON \
-DWITH_QT=ON  \
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


# generate document
make -j4 doxygen
make install
```
**Trouble Shotting**
1. For lastest OpenCV version, will have the below error
    ```sh{.line-numbers}
    fatal error: Eigen/Core: No such file or directory
    #  include <Eigen/Core>
    ```
    Modify file `./modules/core/include/opencv2/core/private.hpp` in Line66 from
    ```cpp{.line-numbers}
    #  include <Eigen/Core>
    ```
    to
    ```cpp{.line-numbers}
    #  include <eigen3/Eigen/Core>
    ```

    Ref: https://github.com/opencv/opencv/issues/14868
1. After install OpenCV, if use python version, below error may occurs
    ```sh{.line-numbers}
    ImportError: /home/jeffery/anaconda3/bin/../lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var

    ImportError: /home/jeffery/anaconda3/bin/../lib/libpangoft2-1.0.so.0: undefined symbol: pango_font_description_set_variations
    ```

    Delete the `libfontconfig.so*` and `libpangoft2-1.0.so*` in `./anaconda3/lib`.

1. sometimes, the pycharm couldnot show the completion for OpenCV library correctly, move `~/anaconda3/lib/python3.7/site-packages/cv2/cv2.cpython-37m-x86_64-linux-gnu.so` to `~/anaconda3/lib/python3.7/site-packages/cv2.cpython-37m-x86_64-linux-gnu.so` and delete the `cv2` folder could solve this problem.


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
    sudo apt-get install libflann-dev libusb-1.0-0-dev libudev-dev freeglut3-dev graphviz libpng16-dev libgtest-dev libxmu-dev libxi-dev libpcap-dev libqhull-dev
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

# Deep Learning
## Pytorch
```sh{.line-numbers}
# CUDA 10.0
conda install pytorch torchvision cuda100 -c pytorch

# install local package
conda install --use-local pytorch-0.4.1-py37_cuda9.2.148_cudnn7.1.4_1.tar.bz2
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