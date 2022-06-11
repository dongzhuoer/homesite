---
title: VSCode 的等宽字体终于“等宽”了
author: Zhuoer Dong
date: '2018-03-23'
slug: vscode-font-finally-mono
categories: 2018
tags: []
authors: []
---

实在受不了 VSCode 中文和英文不等宽的设定，后来发现其实是 `monospace` 字体的错：`"editor.fontFamily": "'Droid Sans Mono', 'monospace', monospace, 'Droid Sans Fallback'"`。`Droid Sans Mono` 只有英文，所以中文实际上用的是 `monospace`（前者就像是个小傀儡）。

不久前解决 RStudio 中文输入后，感觉字体效果挺舒服的，可是其使用的 `Ubuntu Mono` 搬到 Ubuntu 会后总觉得各种不习惯。于是我开始在 [Font Squirrel](https://www.fontsquirrel.com/) 和 [Google Fonts
](https://fonts.google.com/) 搜刮各种等宽字体，然后筛选 ^[还好等宽字体种类不多，不然得累得够呛。] 出一个方块字的宽度等于两个英文字母的。一共筛出了7种，使得我的选择困难症又开始犯了。

比较一番之后，我决定根据缺点来淘汰，下面5位选手就不幸中招了：

```yaml
Lekton: too thin
Fira Sans: g, space too narrow 
Envy Code R: mw
fantasque sans mono: ukh
NanumGothicCoding: qp
```

最后决赛中，我选择了与 `monospace` 最为接近的 `M+ 1m` ^[[`mplus-1m-regular.ttf`](https://github.com/rayshan/mplus-fonts)] （为 `Inconsolata` 默哀）。





