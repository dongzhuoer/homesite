---
title: 复制粘贴怎么就这么难
date: '2017-11-27'
slug: clipboard
categories: 2017
tags: []
authors: []
---



# Preface

Vim 虽好，但有一个问题，就是与其它程序之间的复制粘贴。当时很多程序的设置都是用 `.md` 保存，然后用 Vim 编辑配置文件。所以这个问题给我的早期编程生涯造成了不小的麻烦，尤其是那时候我经常重装系统。


# Two selection

下面两段话忘记是从哪抄过来的了（看这文体肯定不是我写的）：

- The **clipboard** selection is accessed using keyboard shortcuts, while application specific, these are most commonly `ctrl+c` for copying, `ctrl+v` for pasting and `ctlr+x` for cutting.
- The **primary** selection speeds up the copying task by copying the text to the clipboard as soon as it was selected with the mouse, without the need for entering a keyboard shortcut. Pasting is triggered by pressing the middle mouse button (or some emulation of it).



# Vim setting

There are two possible values for `set clipboard=`, `unnamed` and `unnamedplus`.

According to https://stackoverflow.com/questions/30691466

- On Mac OS X and Windows, they have the same effect, they both point to the system **clipboard** selection.
- On Linux, `unnamedplus` is pretty much the same as above, while `unnamed` points to **primary** selection.

So, `set clipboard=unnamedplus` allows you to (1) `ctrl+c` in other programs and paste into Vim with `p` and (2) yank in Vim with `y` and `ctrl+v` into other programs on all three platforms.

You can also use `set clipboard^=unnamed,unnamedplus` to utilize both selection.



# One step forward, VPS

Furthermore, I desire to access system clipboard via SSH. 

Please refer to [this answer](https://stackoverflow.com/questions/36107927).
