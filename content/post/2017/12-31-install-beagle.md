---
title: 在谢老师工作站装 BEAGLE
date: '2017-12-31'
slug: install-beagle
categories: 2017
tags: []
authors: []
---



具体安装时间不记得了。BEAGLE 是用 GPU 来加速分歧时间推断软件 BEAST 的，好像是谢老师和计算机系的人一起开发的。貌似当时的人弄好之后就一直没动过，还有一次跑程序时吴昊阳师兄说当时的人写程序时把随机数写死了，列出这些无非就是想吐槽可重复性之难。

-----------------------------------------

[beagle-lib](https://github.com/beagle-dev/beagle-lib)

- [NVIDIA OpenCL](http://www.nvidia.com/drivers) or `lspci | grep VGA`
- [NVIDIA driver](http://www.nvidia.com/content/DriverDownload-March2009/confirmation.php?url=/XFree86/Linux-x86_64/390.42/NVIDIA-Linux-x86_64-390.42.run&lang=us&type=TITAN)
- [NVIDIA CUDA](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=CentOS&target_version=7&target_type=runfilelocal)

```bash
# epel
sudo yum install -y mesa-libGLU-devel libX11-devel libXi-devel libXmu-devel
sudo yum install -y autoconf automake libtool subversion mingw64-pkg-config java-1.8.0-openjdk-devel

# you have to disable the GPU to install ***.run
sudo systemctl set-default mutli-user.target
sudo reboot

chmod +x ***.run
sudo ./***.run

sudo ln -sr /usr/local/cuda/lib64 /usr/local/cuda/lib 
```



install BEAGLE

```
sudo systemctl set-default graphical.target
sudo reboot

./autogen.sh
./configure --with-opencl=/usr/local/cuda-9.1
sudo make clean
sudo make install
make check

beast -beagle_info
```

当时一直不知道为何会失败，花了快两个小时才意识到，既然 BEAGLE 利用显卡，可能要把显卡打开才能编译。
