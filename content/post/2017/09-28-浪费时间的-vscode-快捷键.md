---
title: 浪费时间的 VSCode 快捷键
date: '2017-09-28'
slug: 浪费时间的-vscode-快捷键
categories: 2017
tags: []
authors: []
---



自从上次被 VSCode 的快捷键闪瞎眼之后，我就被深深地迷住了。然而同时使用 Windows 和 Ubuntu 就注定了此路不会顺利，毕竟键盘只有那么小，悲伤却那么大。要想 VSCode 用的爽，就必须让其他程序（甚至是操作系统）开道。



# `ctrl+space`: IntelliSense

这个在 Windows 上就花了我两个小时，回头到了 Ubuntu 又是一个多小时，最终弃疗。

Windows 就留给微软拼音来切换中英文吧，虽然我几乎用不到，正常人直接 `shift` 搞定。这个应该是一个 bug，GUI 配置和修改注册表都不管用，微软拼音就是不把这个快捷键让给我。（其实在纯英文输入法还是可以用的，可惜我英语还没那么好，有时还是写中文来得爽快，就如本文；而且我又不想用第三方输入法软件，无法 protable 不说，搜狗输入法之流的国产软件简直流氓不如，我只敢让他们在 Ubuntu 上待着。）

Ubuntu 上则是被 Synapse 绑定成启动键了。我想把它改成 Super，可是它貌似很抵触这个键。在我的 GUI 和 `config.json` 双重攻势下，它最终屈服了（我也不知道是怎么改的，反正很难改），然后它就启动不了了，难道这就是之前不让我改的原因。最后我不得不改回来，因为 Synapse 还蛮好用的，可以根据名字（比如 `dconf Editor`）来启动应用而不用去猜 binary 的名字（这里是`dconf-editor`，但不是每个软件都这么容易对应的）。顺便我还把 fcitx 的输入法切换改成了 `super+space`，与 Windows 一致。

最后，我只能把 IntelliSense 绑定到了 `ctrl+alt+space`。只是多按一个键而已，至少两个系统能一致了。

> 然而我之后几乎就没用过这个键。



# `shift+alt+drag`: Box Selection

这个主要是 Ubuntu 要改。最后找到了命令行（nutshell/Ubuntu）和 GUI （`Control Panel` -> `Windows` -> `Bahaviour`）两种方式。有趣的是命令行修改后 GUI 显示的还是原来的值，但 GUI 设置后命令行会显示新值。倒没什么大问题，安装系统后用命令行设置一次，然后不管它就行。

顺便还发掘出了 `super+drag` 来移动程序窗口的技能，以后就不用费力地把鼠标移到窗口最上边了。



# `alt+click`: Add a cursor

这个只能留在 Windows 上用了， Ubuntu 上这个键不知道被谁给绑定了，官方还在探讨[改进方式](https://github.com/Microsoft/vscode/issues/3091)。目前可以改成 `ctrl+click`，但是 Peek Definition 和 Open URL 就挂了，况且我的设置是共用的，真改的话 Windows 上也会遭殃。

不过这个对我倒有点鸡肋，Box Selection 和 Change All Occurrences 在大部分场合应该够用。



# Markdown All in One

今天又批准了一个 VSCode 扩展，主要是自动格式化 table 让我爱不释手。

list editing 也不错，但是测试后只保留了 `tab` 和 `enter`，因为 `baskspace` 有一个 bug [^list-edit-bug]。

`ctrl+enter` 则被我设置的 `Run Code in terminal` 冲突了，无法测试效果。

至于，**Bold** 和 _italic_, 都被我删了。一部分原因是冲突；另一部分是 Markdown 本来就是一种简单的语言，自己 type 几个 `*`、`_` 就够了，同时也能约束我少用强调。但像 list editing 这样方便易用而且不冲突的，何乐而不为呢，貌似我列表用得比强调还多。

最后是 `ctrl+shift+[/]`，竟敢和我宝贵的 Code Fold 作对，果断干掉（虽然我好像更喜欢用鼠标去戳那个小框，即使点不准）。有 Box Selection 在手，不就是一个 `#` 的事吗。

# Update  

后来我又把 **Bold** 和 _italic_ 加回来了。因为我把 `ctrl+i` 改成了更有意义的 `ctrl+l` （select **L**ine）, 然后为了与被去掉的逗逼 `ctrl+j` [^ctrlJ] 对称，`ctrl+b` 也被去掉了，所以就没有冲突了。

[^ctrlJ]: 用于调出下方 Panel，Output 和 Debug console 还好，一旦调出 ternimal 就回不去了，还得按 `` ctrl+` ``，这不是搞笑吗

顺便 build task 也能共用 `ctrl+b`了，希望没有问题吧，浏览 Markdown 文件时应该用不上 build task 。

> 2019-03-15：但后来 **Bold** 和 _italic_ 用得还是很少，而且 blogdown 重度依赖 build task，就又把它们去掉了。

看了一下，`atrl` 还都空着，还是放 sidebar 和 panel 一条生路吧，不过 setting 就只能憋屈到 `alt+shift` 去了（menu 有个 selection 占用了 `atrl+s`）。


[^list-edit-bug]:

    ```
    1. list
        1. backspace before me
    ```
    
    在`b`前删除会变成
    
    ```
    1. list
    1. backspace before me
    ```
    
    这是很好的。
    
    但是对于
    
    ```
    1. list
    1.  backspace before me
    ```
    
    在`b`前删除则会变成
    
    ```
    1. list
    backspace before me
    ```
    
    这是不行的。而且 `shift+tab` 也能完成减少缩进的任务。
