# Setup Development Environment for RoadDB

## Ubuntu 16.04
1. Python, 直接使用conda环境
2. 需要安装的其他第三方库
    ```sh
    sudo apt-get install libbz2-dev libprotoc-dev libprotobuf-dev protobuf-compiler autoconf libvtk6-qt-dev ocl-icd-opencl-dev libproj-dev
    ```
3. 安装PCL, 目前使用的是1.9.1, 最新版的1.11.1需要C++14, 目前代码暂时不支持
4. 安装MKL
    1. 通过[apt-get](https://software.intel.com/content/www/us/en/develop/articles/installing-intel-free-libs-and-python-apt-repo.html)直接安装的, 或先[下载](https://software.intel.com/content/www/us/en/develop/tools/math-kernel-library.html)后再安装
    1. 安装完, 需要设置环境变量, 在`~/.zshrc`中添加下面两行。 参考[confluence](https://confluence.ygomi.com:8443/display/RRT/How+to+setup+environment+to+run+Distributed+SAM+code)或下面中的`.sh`中help说明。
      ```sh
      source /opt/intel/compilers_and_libraries/linux/mkl/bin/mklvars.sh intel64
      source /opt/intel/compilers_and_libraries/linux/mpi/intel64/bin/mpivars.sh release_mt
      ```

## Build
1. `3rdparty`中kml会编译出错, 暂时不管, 参考分支`origin/br-20200921.48768-2020-TRI-AD-Demo`

