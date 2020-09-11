# Vision & SLAM
[TOC]

## OpenVINO
- Method01, install using `apt-get`. 

    **The method seem error during build `OpenCV`**

    1. Install using `apt-get`, see [guide](https://docs.openvinotoolkit.org/latest/openvino_docs_install_guides_installing_openvino_apt.html). Please install the [LST version](https://software.intel.com/content/www/us/en/develop/tools/openvino-toolkit/choose-download.html), the lastest is `2020.3 `.
    1. Don't install `OpenCV`
        ```sh
        # use below command to check the output which packages will be installed
        sudo apt-get install intel-openvino-runtime-ubuntu18-2020.3.194
        
        # only install below packages
        sudo apt-get install intel-openvino-eula-2020.3.194 intel-openvino-gstreamer-rt-ubuntu-bionic-2020.3.194 intel-openvino-gva-rt-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-core-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-cpu-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-gna-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-gpu-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-hddl-ubuntu-bionic-2020.3.194 intel-openvino-ie-rt-vpu-ubuntu-bionic-2020.3.194 intel-openvino-ie-sdk-ubuntu-bionic-2020.3.194 intel-openvino-setupvars-2020.3.194 
        ```
    1. Add path to `~/.zshrc`
        ```sh
        # Add OpenVINO path
        source /opt/intel/openvino/bin/setupvars.sh
        ```

- Method02, download the [LST version](https://software.intel.com/content/www/us/en/develop/tools/openvino-toolkit/choose-download.html), and install manually.
    1. Don't install `OpenCV` and `OpenVX`
       
    2. Add path to `~/.zshrc`
    
        ```sh
        # Add OpenVINO path
        source /opt/intel/openvino/bin/setupvars.sh
        ```

## Jpeg-Turbo

install libjpeg-turbo-2.0.2, modify cmake setting

- select `WITH_JPEG7`
- select `WITH_JPEG8`
- `CMAKE_INSTALL_PREFIX` to `/usr/local`
- `CMAKE_INSTALL_LIBDIR` to `lib`
- `CMAKE_INSTALL_DOCDIR` to `<CMAKE_INSTALL_DATAROOTDIR>/doc/turbojpeg`

## OpenCV

使用`OpenVINO`编译时, 生成的`python`包没有提示, 由于平时用`OpenVINO`比较少, 建议取消

```sh{.line-numbers}
# install dependency
sudo apt-get install libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libavresample-dev libswscale-dev libtbb-dev libtbb2 libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev libopenblas-dev libatlas-cpp-0.6-dev liblapacke-dev ccache
# install jasper
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" # add this if install error
sudo apt-get install libjasper-dev
# freetype
sudo apt-get install libfreetype6-dev libharfbuzz-dev
# others modules dependency
sudo apt-get install libhdf5-dev libtesseract-dev libleptonica-dev

# used for python document
sudo apt-get install python-bs4 python3-bs4
# used for svg document
sudo apt-get install graphviz doxygen

# modify doxygen setting in doc/Doxyfile.in
sed -i 's/^DOT_GRAPH_MAX_NODES.*/DOT_GRAPH_MAX_NODES=500/' ./doc/Doxyfile.in

# uncomment anaconda path
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
-DOPENCV_DOCS_INTERACTIVE_SVG=ON \
-DJPEG_INCLUDE_DIR:PATH="/usr/local/include" \
-DJPEG_LIBRARY_RELEASE:FILEPATH="/usr/local/lib/libjpeg.so" \
-DPYTHON3_PACKAGES_PATH:PATH="/home/jeffery/anaconda3/lib/python3.8/site-packages" \
-DPYTHON3_LIBRARY:FILEPATH="/home/jeffery/anaconda3/lib/libpython3.8.so" \
-DPYTHON3_INCLUDE_DIR:PATH="/home/jeffery/anaconda3/include/python3.8" \
-DPYTHON3_NUMPY_INCLUDE_DIRS:PATH="/home/jeffery/anaconda3/lib/python3.8/site-packages/numpy/core/include" \
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
    #include <Eigen/Core>
    ```
    Modify file `./modules/core/include/opencv2/core/private.hpp` in Line66 from
    ```cpp{.line-numbers}
    #include <Eigen/Core>
    ```
    to
    ```cpp{.line-numbers}
    #include <eigen3/Eigen/Core>
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

1. Install `OpenCV` before `Pangolin` to install some third libraries.

1. Install third libraries

	```shell
	sudo apt-get install libavdevice-dev libglew-dev libopenexr-dev libswscale-dev libuvc-dev libzstd-dev 
	```

1. Modify below code and build

```c++
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