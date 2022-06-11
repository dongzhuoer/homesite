---
title: automatically update R packages, Bioconductor is annoying as usual
author: Zhuoer Dong
date: '2018-12-25'
slug: auto-update-r-packages-damn-bioconductor
categories: 2018
tags: []
authors: []
---

# cause

看到新发布的 **BiocManager** 已经改过自新，我觉得是时候完善一下 systemctl for update R packges 了。这回应该两行就够，简单明了：

```r
remotes::update_packages(upgrade = T)
BiocManager::install(update = T, ask = F)
```

然而，......


# Bioconductor 还是一如既往地烦人

- The first problem is `SSL conect error`, later I find it because BiocManager wants to access https://bioconductor.org/config.yaml

- After the network recovers, BiocManager 的另一个问题是总想着更新 Recommends 的包，但是这是由 apt 管理，用户没权限，然后就报错罢工。我仔细看了参数，无法像 `update.packages()` 那样指定更新哪些包。

- 后来尝试让R不要找 `/usr/lib/R/library/`，而使用我指定的目录，结果是至少在 Linux 会很麻烦。

够了，再用 Bioconductor 出品的东西我就不打农药^[写在2019/02/21：寒假开学后我好像确实不怎么打了，排位上分慢，就算好不容易上了星耀，新赛季还是会一朝回到解放前，还不如看看动漫。]！！


# 向 remotes 求救

转去鼓捣 `remotes::install_bioc()`：

```r
pkgs <- .packages(T)
is_bioc <- sapply(pkgs, utils::packageDescription, fields = 'biocViews')
bioc_pkgs <- pkgs[!is.na(is_bioc)]
```

可惜是直接装，不能像 GitHub 那样比较 sha1。


# 简单粗暴的解决方法

狂人余光创倒是提供了点 [思路](https://guangchuangyu.github.io/cn/2018/09/install-bioconductor-package/)：`setRepositories(ind = 1:2)`。有了这条命令之后，不管是 `update.packages()` 还是 `remotes::update_packages()` 都能同时帮你更新 CRAN 和 BioConductor 的包了（只需要一行就够，岂不爽哉）。

有一点需要注意，不过对我而言倒没什么问题 ^[烦人的 rexseek 我已经专门建了一个 library 解决了。这一点让我体会到，好习惯就应该坚持到底，其它的部分才能很好地配合起来。如果当时将就了，一直用 3.7，现在就会遇到麻烦了。]：

> Bioconductor和R版本绑定，为了确保用户不把包安装在错误的版本上。... 请确保你一直在使用最新版本的R。




# 后记

顺便记一下，`remotes::package_deps(.packages(T)) %>% tibble::as_tibble()` 能提供我以前很想要的关于包的信息。

