---
title: 估计 rexseek 包也没人用，我就任性地放一次鸽子吧，去你的 `scater::normaliseExprs()`
date: '2019-01-28'
slug: rexseek-stand-up-abandon-scater
categories: 2019
tags: []
authors: []
---



# Preface

`scater::normaliseExprs()` 真乃神人，Bioconductor 3.7 还好好的。到了 3.8 就一脚踹开，装模作样地提供一个替代函数，但根本不告诉你具体怎样才能得到相同的效果。

我之前就降级到 3.7 了。后来好像 ggtree 又出问题了，非要最新版才肯干活。我琢磨着一直用旧版也不是个事，就升回 3.8 了。

于是就给 rexseek 专开了一个 library

`.Rprofile`
```r
if (file.exists('~/.Rprofile')) source('~/.Rprofile')

.libPaths(c('~/.local/lib/R-rexseek', '/usr/lib/R/library'))
```



# Beginning

然后我在整理 `lulab-rotation-summary` 中的 rexseek 教程时把自己坑了。于是有个函数开始报 warning，我就改 rexseek 的源代码，加上 `suppressMessages()`, 但是还在报错，这就奇了怪了。



# Development

直接打印修改完的函数，发现没修改。这是我突然意识到 rexseek 被安装到我专门建的 library 了。这还不好修复，安装时要检查依赖包都在的，结果我只好在安装后复制一份到标准的 library。

但更大的问题不在这，`rmarkdown::render()` rexseek 教程用的还是标准的 library，那么 rexseek 调用 `scater::normaliseExprs()` 的代码就总会失效。



# Climax

最后我决定干脆不用这个函数了。当时我还是要负责的，`warning()` 肯定要有的，我还用前不久学到的 tidy eval 打印出了能实现功能的代码（如果用户真的愿意装上 3.7，就可以自己运行）

```r
rexseek::norm_tmm(matrix(1:6, nrow = 2))
## rexseek no longer provides the norm_tmm() function.
## If you use Bioconductor 3.7, and have scater installed,
##     you can run the following command yourself:
## library(magrittr)
## matrix(1:6, nrow = 2) %>% rexseek::as_SingleCellExperiment() %>% 
##     scater::normaliseExprs(., "TMM") %>% 
##     scater::normalise() %>% SingleCellExperiment::normcounts()
## 
## Warning in rexseek::norm_tmm(matrix(1:6, nrow = 2)): norm_tmm() is
## deprecated, returning the original matrix.
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```
