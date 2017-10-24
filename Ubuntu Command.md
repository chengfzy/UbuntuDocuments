# Basic
## VirtualBox
```sh
sudo mount -t vboxsf E /mnt/E
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
```

## CMake
```sh
sudo apt-get install cmake-qt-gui
```

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
make
``` sh
cmake \
-DCMAKE_BUILD_TYPE=RELEASE \
-DCMAKE_CONFIGURATION_TYPES:STRING="Debug;Release" \
-DCMAKE_INSTALL_PREFIX=/home/jeffery/Programs/opencv \
-DOPENCV_EXTRA_MODULES_PATH:PATH="/home/jeffery/Documents/SourceCode/OpenCV/opencv3.3.0/contrib/modules" \
-DBUILD_opencv_dnn_modern:BOOL="0" \
-DBUILD_opencv_contrib_world:BOOL="1" \
-DBUILD_opencv_world:BOOL="1" \
-DBUILD_opencv_sfm:BOOL="0" \
-DOPENCV_ENABLE_NONFREE:BOOL="1" \
-DENABLE_CXX11:BOOL="1" \
-DBUILD_opencv_python2=OFF \
-DBUILD_opencv_python3=ON \
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

## Ceres
```sh
sudo apt-get install libsuitesparse-dev
cmake ...
```