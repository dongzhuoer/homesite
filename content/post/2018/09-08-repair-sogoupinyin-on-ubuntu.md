---
title: repair sogoupinyin on Ubuntu
author: Zhuoer Dong
date: '2018-09-08'
slug: repair-sogoupinyin-on-ubuntu
categories: 2018
tags: []
authors: []
---

`sogoupinyin` suddenly broken several days ago, _candidate word_ becomes letter and numbers, rather than Chinese character.

As a temporary solution, I switch to other Pinyin. But `sogoupinyin` is really far more _superior_ than them.

Today morning, I Google the problem, and see some discussion:

```bash
rm -r ~/.config/SogouPY
rm -r ~/SogouPY.users
```

Surprisingly, it works ^[Expect that Ubuntu halted and I have to restart it.]! 
