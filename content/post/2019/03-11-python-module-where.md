---
title: python module 都去哪了
date: '2019-03-11'
slug: python-module-where
categories: 2019
tags: []
authors: []
---



自从彻底弄清楚装 R 包的事之后，总觉得 Python module 装得不明不白的，就知道一个 `--user`。今天上午鼓捣了一会儿，终于弄懂了。

首先是找到了 `python3 -m site`，会列出一些重要的 path。然后用 `apt-file find` 来找 `apt` install 的 module 藏在哪；`sudo -H pip3` [^pip._internal] install 的 module 在哪。

最终结论是：

- `apt install python3-***`: `/usr/lib/python3/dist-packages`
- `sudo -H pip3 install ***`: `/usr/local/lib/python3.6/dist-packages`
- `pip3 install *** --user`: `~/.local/lib/python3.6/site-packages`

后日谈：其实我本来是想找类似于 `pip3 list --system` 的命令，这样就可以把 site module 都卸掉，只保留 user module，可惜没有。不过 `ls` 相应的目录也可以达成目的，结论是我装的 module 只有第1种和第3种，根本不用操心 site module。


[^pip._internal]:
    ```
    Traceback (most recent call last):
      File "/usr/bin/pip3", line 7, in <module>
        from pip._internal import main
    ModuleNotFoundError: No module named 'pip._internal'
    ```
    如果遇到以上错误，压根不用管，直接 reinstall `python3-pip`。
