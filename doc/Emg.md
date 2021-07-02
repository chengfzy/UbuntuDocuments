# EMG电脑配置
[TOC]

## 系统安装
1. 使用`Startup Disk Creator`制作Ubuntu 18.04镜像，开始时按F12选择U盘并安装系统

## NVIDIA驱动安装及CUDA
1. 开机时按F1将`Secure Boot`设成`Disable`
1. 不要使用`apt`自带的驱动，如有请卸载
1. 重启后进入系统，下载CUDA的.run文件，并安装，再重启成功. 注意不要使用`Ctrl+Alt+F3`进入命令行安装

## 指纹登陆
1. Ubuntu20.04网上说自带的就能用
1. Ubuntu18.04试过不行

## 坑1: OpenGL
安装`Pangolin`或`PCL`配置时会出现如下错误
    ```
    Could NOT find OpenGL (missing: OPENGL_glx_LIBRARY)
    ```
### 解决方案
1. 使用了最新的cmake有bug, 改成系统自带的问题解决
1. 但上述解决只是说`cmake`不报错, 该文件还是没找到的, 在编译的时候仍会报错, 需要将相关的模块禁用掉才可以.