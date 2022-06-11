---
title: 傲娇的 RStudio Viewer Panel
author: Zhuoer Dong
date: '2017-11-04'
slug: tsundere-rstudio-viewer-panel
categories: 2017
tags: []
authors: []
---

当时在鼓捣 bookdown，尤其是 build others' book。

突然发现 RStudio Viewer panel 无法正常显示 book。

调试一番之后，发现是由于 link to a CSS file out of the output directory.

So I use Rscript `website/bookdown/bookname` to add CSS file.

Update: on 11/07, I give up it, maybe I will report the bug someday. Anyway, I decide to stick to `/bookdown.css`, because you can see the effect immediately after modifying the CSS file without building again.

Update on 12/07: I saw that RStudio's View panel only works for local resources. That might explain this issue.
