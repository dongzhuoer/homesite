---
title: 用 VMware 折腾虚拟机
date: '2018-01-25'
slug: vmware-虚拟机
categories: 2018
tags: []
authors: []
---



以前还热衷于虚拟机，那会倒腾 VMware 得爱不释手。


# Windows 10, get rid of update

install Pro without internet => make snapshot 1.0 => pause Windows update  

Then any time you revert 1.0 you can pause Windows update again, i. e. you can get rid of Windows update.



# Windows 7 execute .exe
  
开始 => 运行 => gpedit.msc=> 用户配置 => 管理模板 => windows组件 => 附件管理器=> 右击 "中等危险文件类型的包含列表" => 属性 => 选"已启用" => 在指定中等危险扩展名里输入.exe => 确定
  


# CentOS 7 vmware-tools

```bash
sudo yum -y install gcc make kernel-devel
sudo yum remove open-vm-tools   # otherwise you can't use shared folder
sudo ./vmware-install.pl -d          
```

Don't `yum check-update`, otherwise vmware-tools would suggest you to use `open-vm-tools`, and the worst thing is that the default option is ture. Since you use `-d`, the installion would abort, so you can't use `-d`, and need to type no for first option, then thousands of Enter for chosing default options.
