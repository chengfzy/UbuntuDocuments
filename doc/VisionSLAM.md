# Vision & SLAM
[TOC]

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
-DOPENCV_DOCS_INTERACTIVE_SVG=ON \
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