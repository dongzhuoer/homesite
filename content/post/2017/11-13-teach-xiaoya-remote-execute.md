---
title: 教小雅师姐用 SSH 远程在工作站跑程序
date: '2017-11-13'
slug: teach-xiaoya-remote-execute
categories: 2017
tags: []
authors: []
---



大四在四教做科研的时候，我们在 205，工作站在谢老师办公室（记不清了，好像是 213）。虽然从门口到门口才不出 10 步的距离，但我还是喜欢坐在办公桌前就能“远程”把工作站上的程序跑了。在掌控了 213 的 wifi 之后[^1]，借助于老师的固定 IP，SSH 自然是顺理成章的事。好东西自然要给大家分享，于是就用微信写了下面的教程（包括 `nohup` 和输出流重定向）：

[^1]: 于老师的 Windows Server 2003（具体版本不记得了）既要作为网站主机，又要作为路由器给屋里的老师上网。某天我手残地弄坏了，修了好久（主要是缺乏文档），最后绝望的我用钱解决了问题：买了个 TP-LINK 路由器。

--------------------------------------------

给师姐做了个小例子

`test-ssh.sh`
```bash
#!/bin/bash

> /tmp/test-ssh.out

for i in {1..60};
do
    sleep 1;
    echo sleep at `date` >> /tmp/test-ssh.out;
    echo sleep ${i}th second;
done
```

这个程序会运行60秒，在屏幕上显示60行字，并生成一个文件

```
[entomo@localhost ~]$ test-ssh.sh
sleep 1th second
sleep 2th second
sleep 3th second
sleep 4th second
sleep 5th second
sleep 6th second
sleep 7th second
sleep 8th second
sleep 9th second
sleep 10th second
sleep 11th second
sleep 12th second
sleep 13th second
sleep 14th second
sleep 15th second
sleep 16th second
sleep 17th second
sleep 18th second
sleep 19th second
sleep 20th second
sleep 21th second
sleep 22th second
sleep 23th second
sleep 24th second
sleep 25th second
sleep 26th second
sleep 27th second
sleep 28th second
sleep 29th second
sleep 30th second
sleep 31th second
sleep 32th second
sleep 33th second
sleep 34th second
sleep 35th second
sleep 36th second
sleep 37th second
sleep 38th second
sleep 39th second
sleep 40th second
sleep 41th second
sleep 42th second
sleep 43th second
sleep 44th second
sleep 45th second
sleep 46th second
sleep 47th second
sleep 48th second
sleep 49th second
sleep 50th second
sleep 51th second
sleep 52th second
sleep 53th second
sleep 54th second
sleep 55th second
sleep 56th second
sleep 57th second
sleep 58th second
sleep 59th second
sleep 60th second
[entomo@localhost ~]$ cat /tmp/test-ssh.out
sleep at Mon Nov 13 22:29:13 CST 2017
sleep at Mon Nov 13 22:29:14 CST 2017
sleep at Mon Nov 13 22:29:15 CST 2017
sleep at Mon Nov 13 22:29:16 CST 2017
sleep at Mon Nov 13 22:29:17 CST 2017
sleep at Mon Nov 13 22:29:18 CST 2017
sleep at Mon Nov 13 22:29:19 CST 2017
sleep at Mon Nov 13 22:29:20 CST 2017
sleep at Mon Nov 13 22:29:21 CST 2017
sleep at Mon Nov 13 22:29:22 CST 2017
sleep at Mon Nov 13 22:29:23 CST 2017
sleep at Mon Nov 13 22:29:24 CST 2017
sleep at Mon Nov 13 22:29:25 CST 2017
sleep at Mon Nov 13 22:29:26 CST 2017
sleep at Mon Nov 13 22:29:27 CST 2017
sleep at Mon Nov 13 22:29:28 CST 2017
sleep at Mon Nov 13 22:29:29 CST 2017
sleep at Mon Nov 13 22:29:30 CST 2017
sleep at Mon Nov 13 22:29:31 CST 2017
sleep at Mon Nov 13 22:29:32 CST 2017
sleep at Mon Nov 13 22:29:33 CST 2017
sleep at Mon Nov 13 22:29:34 CST 2017
sleep at Mon Nov 13 22:29:35 CST 2017
sleep at Mon Nov 13 22:29:36 CST 2017
sleep at Mon Nov 13 22:29:37 CST 2017
sleep at Mon Nov 13 22:29:38 CST 2017
sleep at Mon Nov 13 22:29:39 CST 2017
sleep at Mon Nov 13 22:29:40 CST 2017
sleep at Mon Nov 13 22:29:41 CST 2017
sleep at Mon Nov 13 22:29:42 CST 2017
sleep at Mon Nov 13 22:29:43 CST 2017
sleep at Mon Nov 13 22:29:44 CST 2017
sleep at Mon Nov 13 22:29:45 CST 2017
sleep at Mon Nov 13 22:29:46 CST 2017
sleep at Mon Nov 13 22:29:47 CST 2017
sleep at Mon Nov 13 22:29:48 CST 2017
sleep at Mon Nov 13 22:29:59 CST 2017
sleep at Mon Nov 13 22:29:50 CST 2017
sleep at Mon Nov 13 22:29:51 CST 2017
sleep at Mon Nov 13 22:29:52 CST 2017
sleep at Mon Nov 13 22:29:53 CST 2017
sleep at Mon Nov 13 22:29:54 CST 2017
sleep at Mon Nov 13 22:29:55 CST 2017
sleep at Mon Nov 13 22:29:56 CST 2017
sleep at Mon Nov 13 22:29:57 CST 2017
sleep at Mon Nov 13 22:29:58 CST 2017
sleep at Mon Nov 13 22:29:59 CST 2017
sleep at Mon Nov 13 22:30:00 CST 2017
sleep at Mon Nov 13 22:30:01 CST 2017
sleep at Mon Nov 13 22:30:02 CST 2017
sleep at Mon Nov 13 22:30:03 CST 2017
sleep at Mon Nov 13 22:30:04 CST 2017
sleep at Mon Nov 13 22:30:05 CST 2017
sleep at Mon Nov 13 22:30:06 CST 2017
sleep at Mon Nov 13 22:30:07 CST 2017
sleep at Mon Nov 13 22:30:08 CST 2017
sleep at Mon Nov 13 22:30:09 CST 2017
sleep at Mon Nov 13 22:30:10 CST 2017
sleep at Mon Nov 13 22:30:11 CST 2017
sleep at Mon Nov 13 22:30:12 CST 2017
[entomo@localhost ~]$ 
```

如果等它运行完，结果会像上面这样

但是一个长时间运行的程序，更多的情况下是会被打断的，比如网络不好或者终端突然被关了

然后我现在用 `ctrl+c`来模拟一下被打断

```
[entomo@localhost ~]$ test-ssh.sh
sleep 1th second
sleep 2th second
sleep 3th second
sleep 4th second
sleep 5th second
^C
[entomo@localhost ~]$ cat /tmp/test-ssh.out
sleep at Mon Nov 13 22:35:14 CST 2017
sleep at Mon Nov 13 22:35:15 CST 2017
sleep at Mon Nov 13 22:35:16 CST 2017
sleep at Mon Nov 13 22:35:17 CST 2017
sleep at Mon Nov 13 22:35:18 CST 2017
[entomo@localhost ~]$ 
```

可以看到生成的文件，只有一小部分。对应到师姐去运行一些真正的程序的话，很可能在输出文件的时候，只有某些文件的一部分生成了，大部分都还没有算完

```
[entomo@localhost ~]$ nohup test-ssh.sh &> /tmp/test-ssh.log &
[1] 27433
[entomo@localhost ~]$ exit
logout
Connection to localhost closed.
```

这个时候我们就要请出一个神奇的命令，你看我用完之后是把整个连接给断开了

但没有关系，我的程序还是会正常的运行，然后直到完成

```
[entomo@localhost ~]$ cat /tmp/test-ssh.out
sleep at Mon Nov 13 22:30:09 CST 2017
sleep at Mon Nov 13 22:30:10 CST 2017
sleep at Mon Nov 13 22:30:11 CST 2017
sleep at Mon Nov 13 22:30:12 CST 2017
sleep at Mon Nov 13 22:30:13 CST 2017
sleep at Mon Nov 13 22:30:14 CST 2017
sleep at Mon Nov 13 22:30:15 CST 2017
sleep at Mon Nov 13 22:30:16 CST 2017
sleep at Mon Nov 13 22:30:17 CST 2017
sleep at Mon Nov 13 22:30:18 CST 2017
sleep at Mon Nov 13 22:30:19 CST 2017
sleep at Mon Nov 13 22:30:20 CST 2017
sleep at Mon Nov 13 22:30:21 CST 2017
sleep at Mon Nov 13 22:30:22 CST 2017
sleep at Mon Nov 13 22:30:23 CST 2017
sleep at Mon Nov 13 22:39:24 CST 2017
sleep at Mon Nov 13 22:39:25 CST 2017
sleep at Mon Nov 13 22:39:26 CST 2017
sleep at Mon Nov 13 22:39:27 CST 2017
sleep at Mon Nov 13 22:39:28 CST 2017
sleep at Mon Nov 13 22:39:29 CST 2017
sleep at Mon Nov 13 22:39:30 CST 2017
sleep at Mon Nov 13 22:39:31 CST 2017
sleep at Mon Nov 13 22:39:32 CST 2017
sleep at Mon Nov 13 22:39:33 CST 2017
sleep at Mon Nov 13 22:39:34 CST 2017
sleep at Mon Nov 13 22:39:35 CST 2017
sleep at Mon Nov 13 22:39:36 CST 2017
sleep at Mon Nov 13 22:39:37 CST 2017
sleep at Mon Nov 13 22:39:38 CST 2017
sleep at Mon Nov 13 22:39:39 CST 2017
sleep at Mon Nov 13 22:39:40 CST 2017
sleep at Mon Nov 13 22:39:41 CST 2017
sleep at Mon Nov 13 22:39:42 CST 2017
sleep at Mon Nov 13 22:39:43 CST 2017
sleep at Mon Nov 13 22:39:44 CST 2017
sleep at Mon Nov 13 22:39:45 CST 2017
sleep at Mon Nov 13 22:39:46 CST 2017
sleep at Mon Nov 13 22:39:47 CST 2017
sleep at Mon Nov 13 22:39:48 CST 2017
sleep at Mon Nov 13 22:39:59 CST 2017
sleep at Mon Nov 13 22:39:50 CST 2017
sleep at Mon Nov 13 22:39:51 CST 2017
sleep at Mon Nov 13 22:39:52 CST 2017
sleep at Mon Nov 13 22:39:53 CST 2017
sleep at Mon Nov 13 22:39:54 CST 2017
sleep at Mon Nov 13 22:39:55 CST 2017
[entomo@localhost ~]$ cat /tmp/test-ssh.out
sleep at Mon Nov 13 22:30:09 CST 2017
sleep at Mon Nov 13 22:30:10 CST 2017
sleep at Mon Nov 13 22:30:11 CST 2017
sleep at Mon Nov 13 22:30:12 CST 2017
sleep at Mon Nov 13 22:30:13 CST 2017
sleep at Mon Nov 13 22:30:14 CST 2017
sleep at Mon Nov 13 22:30:15 CST 2017
sleep at Mon Nov 13 22:30:16 CST 2017
sleep at Mon Nov 13 22:30:17 CST 2017
sleep at Mon Nov 13 22:30:18 CST 2017
sleep at Mon Nov 13 22:30:19 CST 2017
sleep at Mon Nov 13 22:30:20 CST 2017
sleep at Mon Nov 13 22:30:21 CST 2017
sleep at Mon Nov 13 22:30:22 CST 2017
sleep at Mon Nov 13 22:30:23 CST 2017
sleep at Mon Nov 13 22:39:24 CST 2017
sleep at Mon Nov 13 22:39:25 CST 2017
sleep at Mon Nov 13 22:39:26 CST 2017
sleep at Mon Nov 13 22:39:27 CST 2017
sleep at Mon Nov 13 22:39:28 CST 2017
sleep at Mon Nov 13 22:39:29 CST 2017
sleep at Mon Nov 13 22:39:30 CST 2017
sleep at Mon Nov 13 22:39:31 CST 2017
sleep at Mon Nov 13 22:39:32 CST 2017
sleep at Mon Nov 13 22:39:33 CST 2017
sleep at Mon Nov 13 22:39:34 CST 2017
sleep at Mon Nov 13 22:39:35 CST 2017
sleep at Mon Nov 13 22:39:36 CST 2017
sleep at Mon Nov 13 22:39:37 CST 2017
sleep at Mon Nov 13 22:39:38 CST 2017
sleep at Mon Nov 13 22:39:39 CST 2017
sleep at Mon Nov 13 22:39:40 CST 2017
sleep at Mon Nov 13 22:39:41 CST 2017
sleep at Mon Nov 13 22:39:42 CST 2017
sleep at Mon Nov 13 22:39:43 CST 2017
sleep at Mon Nov 13 22:39:44 CST 2017
sleep at Mon Nov 13 22:39:45 CST 2017
sleep at Mon Nov 13 22:39:46 CST 2017
sleep at Mon Nov 13 22:39:47 CST 2017
sleep at Mon Nov 13 22:39:48 CST 2017
sleep at Mon Nov 13 22:39:59 CST 2017
sleep at Mon Nov 13 22:39:50 CST 2017
sleep at Mon Nov 13 22:39:51 CST 2017
sleep at Mon Nov 13 22:39:52 CST 2017
sleep at Mon Nov 13 22:39:53 CST 2017
sleep at Mon Nov 13 22:39:54 CST 2017
sleep at Mon Nov 13 22:39:55 CST 2017
sleep at Mon Nov 13 22:39:56 CST 2017
sleep at Mon Nov 13 22:39:57 CST 2017
sleep at Mon Nov 13 22:39:58 CST 2017
sleep at Mon Nov 13 22:39:59 CST 2017
sleep at Mon Nov 13 22:40:00 CST 2017
```

这些内容之前会显示在屏幕上，但是我现在把它存到一个文件里面去，这是我再次登录进去之后，两次查看文件的内容。可以看到我第二次看的时候内容比第一次多了一点。这就像你正常在终端运行程序的时候，输出的信息就会越来越多

之后可以再去查看一下之前指定的输出文件的信息，可以发现，即使被我打断了。输出文件的信息，还是跟之前没有打断的时候，是一样的。然后可以看一下我用来保存屏幕信息的这个文件，它的内容跟我之前截图把屏幕信息截下来截图也是一样的

这个我就不再截图了，就是自己用 `cat` 将文件就好了，也算一个练习吧

`nohup  需要长时间运行的命令 &> /tmp/取个自己记得的名字.log &`

`cat /tmp/取个自己记得的名字.log`

核心命令就是上面两行。先运行第一行去跑程序，然后这时候屏幕上就没有任何的信息显示。接着不断的地运行第二行命令，这样的话就能够看到以前本来会显示在屏幕上的信息
