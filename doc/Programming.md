# Programming
[TOC]

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

### Regex
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

## Docker

1. [Install on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
2. 配置镜像加速
	- https://www.runoob.com/docker/docker-mirror-acceleration.html
	- https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors?spm=5176.12901015.0.i12901015.76b5525c3nd8q1

### Troubleshooting

#### 安装完后`docker run hello-world`报错/不用`sudo`也能使用`docker`命令

```sh
$ docker run hello-world
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/create: dial unix /var/run/docker.sock: connect: permission denied.
See 'docker run --help'.
```
1. 添加docker属组(如果没有)
	```sh
	sudo groupadd docker
	```
1. 将用户加入该group中，退出并重新登陆
	```sh
	sudo gpasswd -a ${USER} docker
	```
1. 重启docker服务
	```sh
	sudo service docker restart
	```
1. 切换当前会话到新group或重启会话
	```sh
	newgrp - docker
	```
1. 重启后，从此，docker前再也不用`sudo`啦

Ref: https://zhuanlan.zhihu.com/p/38861499

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
Could install using package management, see [example](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork).

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
Could install using package management, see [install guide](https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#cudnn-package-manager-installation-overview).

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

1. fmt

    ```
    cmake -DBUILD_SHARED_LIBS=TRUE -DFMT_TEST=OFF -DFMT_DOC=OFF ..
    ```

1. nlohmann json

1. yaml-cpp

1. SQLiteCpp

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