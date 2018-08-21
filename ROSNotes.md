# ROS Notes
Some notes and command used in ROS


## Installation
### Install ROS Kinetic on Ubuntu 16.04
Ref:
1. Install: http://wiki.ros.org/kinetic/Installation/Ubuntu
2. Anaconda: https://blog.csdn.net/qq_33521754/article/details/78829212
```sh
# install
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
sudo rosdep init
rosdep update

# update path to use
source /opt/ros/kinetic/setup.bash

# modify to use anaconda
conda install setuptools
pip install -U rosdep rosinstall_generator wstool rosinstall six vcstools
# or comment PATH in ~/.zshrc
# export PATH="/home/jeffery/anaconda3/bin:$PATH"
```

## Basic
### Basic Command
```sh
printenv | grep ROS
rospack find
roscd
roscd log
rosls
catkin_create_pkg <package_name> [depdend1] [depedent2]
catkin_make

rospack depends1 <package_name> # first order dependencies
rospack depends <package_name>  # all dependencies
rospack profile # update packages after source ./devel/setup.zsh if src contains multiple packages

roscp [package_name] [file_to_copy_path] [copy_path]    # copy
```

### ROS Nodes
- Nodes
- Messages
- Topics
- Master
- rosout
- roscore
```sh
rosnode list
rosnode info /rosout
rosrun [package_name] [node_name]
# reassign name
rosrun [package_name] [node_name] __name:=<new_name>

rosnode ping my_turtle
```

### ROS Topics
```sh
rosrun rqt_graph rqt_graph
rostopic -h
rostopic echo [topic]
rostopic list
rostopic list -h
rostopic list -v
rostopic type [topic]
rosmsg show [msg]
rostopic pub [topic] [msg_type] [args]
```

### ROS Services and Parameters
```sh
rosservice call [service] [args]
rosservice type [service] | rossrv show # show arguments
rosparam list
rosparam set [param_name]
rosparam get [param_name]
rosparam dump [file_name] [namespace]
rosparam load [file_name] [namespace]
```

### rqt_console and roslaunch
```sh
rosrun rqt_console rqt_console
rosrun rqt_logger_level rqt_logger_level
roslaunch [package] [filename.launch]
```

### rosed
```sh
rosed [package_name] [filename]
```

### ROS msg and srv
- msg: simple text files that describe the fields of a ROS message
- srv: describe a service, include a request and a response
```sh
rosmsg show [message type]
rossrv show [message type]
```

### Publisher and Subscriber
```sh
cd ~/catkin_ws/src
ls -l  # Take note of the actual symlink target
sed -i '' CMakeLists.txt
ls -l # The symlink should have gone away
```

### Service and Client

### Bag Files
```sh
rosbag record -a    # roscord all topics
rosbag info <bagfile>
rosbag help
rosbag play <bagfile>
rosbag play --help
```

### roswtf
diagnosing issues with a running ROS system


## rviz