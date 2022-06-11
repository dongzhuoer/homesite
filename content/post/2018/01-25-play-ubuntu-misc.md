---
title: 折腾 Ubuntu 杂记
author: Zhuoer Dong
date: '2018-01-25'
slug: play-ubuntu-misc
categories: 2018
tags: []
authors: []
---



# Ralink 3070

> 当时想让台式机也能连 wifi，最重要的是分享网络（一脸邪恶），但360随身WIFI 在 Ubuntu 不好使，于是我就专门在淘宝搜了一个支持 Ubuntu的，可惜还是不好搞啊。

有人说要安装 `firmware-misc-nonfree`， 就 [搜了一下](https://packages.debian.org/search?searchon=names&keywords=+firmware-misc-nonfree)

```bash
sudo dpkg -i --force-overwrite firmware-misc-nonfree_20161130-3_all.deb 
```

后来发现问题在于，WIFI 默认会使用随机地址。（所以上一条也许不是必需的）

`vim /etc/NetworkManager/NetworkManager.conf`
```
[device]
wifi.scan-rand-mac-address=0
```



# mime

> 当时特别想用编程的方式，设置文件类型关联的默认应用，这样重装系统就方便多了。最后还是放弃了，就用 GUI 慢慢 click 吧，反正我只是在系统更新时才重装。

```bash
mimetype .tsv
sudo find / -name mimeapps.list
update-alternatives
xdg-mime --manual
```



# extract initramfs image

当时在看鸟哥的书，后面越来越复杂。看到修改启动镜像（initramfs）时觉得很有意思，就像试一试。结果第一步解压就失败了，于是找到了一篇 [博客](http://thegeekdiary.com/centos-rhel-7-how-to-extract-initramfs-image-and-editview-it/):

```bash
mkdir /tmp/initramfs; cd /tmp/initramfs
sudo cp /boot/initramfs-`uname -r`.img initramfs.img
sudo /usr/lib/dracut/skipcpio initramfs.img | zcat | cpio -ivd
```



# software

- dconf Editor

- Firefox avoid homepage locking  
  `vim /usr/lib/firefox/ubuntumate.cfg`

- TexLive `tlmgr`

   ```bash
   apt install -y xzdec perl-tk
   tlmgr init-usertree #only needed for the first time
   tlmgr --gui
   ```
- `7z` usage

   ```bash
   7z x dir.7z -o/tmp -p****** -y
   7z a vbird_linux_basic.7z vbird_linux_basic -mx=0 -p******* -mhe -v1g
   7z a vbird_linux_basic.7z vbird_linux_basic -mx=0 -p******* -mhe
   ```

- Qt uninstall

  ```bash    
  cd Qt5.6.0
  ./MaintenanceTool
  ```

- Wine  

  1. videocutterjointer 用到simsun.ttc
  1. Times New Roman 由 timesbi、timesi、times、timesbd 提供

- Synapse configuration file 

  `~/.config/synapse/config.json`











