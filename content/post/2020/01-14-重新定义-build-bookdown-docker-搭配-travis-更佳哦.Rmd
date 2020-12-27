---
title: 重新定义 build bookdown，Docker 搭配 Travis 更佳哦
author: Zhuoer Dong
date: '2020-01-14'
slug: 重新定义-build-bookdown-docker-搭配-travis-更佳哦
categories: 2020
tags: []
authors: []
---



> 2020-08-23 前言：在维持开发环境一致性方面，Travis 确实做得很好，但还是 Docker 更彻底，debug 时能保证 local 和 server 完全一样。

[build bookdown](https://github.com/dongzhuoer/autobookdown) 更改实现方式，用了 Docker 之后就优雅多了（`-w` 任我行），不用再像 Travis 那样担心 working directory。附 Travis 实现的逻辑：

The biggest restraint is that `bookdown::render_book()` requires workspace at the book folder.

For _blogdown_, `.Rmd` lives in `docs/`. If you `setwd()` to there, many paths would be relative to it (like `../../output`, `../../extra/_output.yaml`). 

So I thought about adding a environment variable `input_sub_dir`. But _blogdown_ doesn't collaborate, it refer to the some source code of the package by `../R/***.R`.

Suddenly, I realized that instead of setting every path relative to workspace, we can have `to_work_dir` to walk to `$work_dir`. In this way, every other path remains unchanged (`output`, `extra/_output.yaml`), user only need to customize `rmd_dir` & `to_work_dir`, like `rmd_dir=.; to_work_dir=..;`, `rmd_dir=docs; to_work_dir=../..;`.
