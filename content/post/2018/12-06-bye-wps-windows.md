---
title: WPS（on Windows）, 我再也不破解你了
date: '2018-12-06'
slug: bye-wps-windows
categories: 2018
tags: []
authors: []
---



以前我在南开时，曾喜欢定期重装系统，Windows 的 Office 比较难搞，就算我买了破解版，装起来也要好久（联网下载，Nankai LAN 你懂的）。再加上磁盘空间问题，于是对 WPS 情有独钟。可是 WPS 会自动更新，最可恶的是打开时默认有个什么模板首页，浪费时间还耗流量。

魔高一尺道高一丈，破解之（需要替换版本号）：

```batch
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\khomepage.dll"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\kwhatnewdlg.dll"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\wpscenter.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\wpscloudsvrimp.dll"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\wpscloudlaunch.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\wpscloudsvr.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\wpsrenderer.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\ksolaunch.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\office6\ksomisc.exe"

del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\desktoptip.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\updateself.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\wpsnotify.exe"
del "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\wpsupdate.exe"

echo haha >> "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\desktoptip.exe"
echo doubi >> "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\updateself.exe"
echo doubi >> "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\wpsnotify.exe"
echo doubi >> "C:\Users\Allan\AppData\Local\Kingsoft\WPS Office\10.1.0.6749\wtoolex\wpsupdate.exe"

set /p dummy="Press any key to exit"
```

后来逐渐抛弃 Windows，新买的 matebook 也自带 Office，就用不上了。
