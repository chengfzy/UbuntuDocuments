# Deep Learning
[TOC]

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