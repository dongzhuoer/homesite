---
title: 再也不用担心build新的bookdown书了
date: '2018-12-03'
slug: 再也不用担心build新的bookdown书了
categories: 2018
tags: []
authors: []
---



今天花了一整天建好了 build-bookdown 的模板，以后 build 新的书就只需要把最前面的参数改一下，再也不用像以前那样加一本书就要数小时。

除了 bookdown，这次的工作还积累了(1) Travis 自动做任务和(2) Docker 中使用 R [^1] 的经验，为后面开展 Docker testthat (12-08 ~ 12-10) 和 Travis .Rmd pipeline (01-27) 打下了基础。

[^1]: 这一点确实不轻松，12/06 还发现并修复了一个漏洞

以下是一些感悟：

- debug 很重要，好多细节真是只有跑了才能发现。

- 最要命的还是缓存，尤其是 r4ds 等，第一次要半小时多。晚上想着一定要做完，只能干等 ，根本没心思做别的事。

- 更悲剧的是还得跑多次来确定具体需要哪些系统软件。最后决定不干了，`zhuoerdown`  的 Docker 直接都装上，反正是我自己用。

- 同时也启发我 `devtools` 的 Docker 也可以都装上（也许是最大的收获）。要是真的嫌这些污染了系统，那就连 **devtools** 也不要装了，自己下载 `.tar.gz` 用 `R CMD` 安装去。
