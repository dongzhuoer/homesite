---
title: Use Docker to test R packages on Travis
date: '2018-12-09'
slug: docker-testthat-on-travis
categories: 2018
tags: []
authors: []
---



# Preface

Back to 11/30, I reach a conclusion: although using Docker to test R package can figures out _excatly_[^1] what the package needs. it doesn't _worths_ the time needed to develop such an approach, unless Travis broken _again_. (Travis 现成的 R 环境多好啊，还支持 OS X 和多个 R 版本)

[^1]: including but not limited to system softwares, such as `libssl-dev`.



# Beginning

Since yesterday, I began to organize my R package template. 



# Development

I add `devtools` to `Suggests`, then Travis CI failed. After debug, it says some packages are not available for R 3.5.1. That was very strange, since I use that version on my own computer. 

After several trail, I got tried and decided to give up. I realized that debugging R on Travis is so annoying and time-consuming, so I'd better switch to Docker (真香).



# Climax

- The biggest advantage is that it's easier to have the same environment on remote & local. Good news is that I have already established how to use R Docker on Travis. Bad news is the need to cache R packages.

- I can also separate install & test now, previously packages like `testthat` would interfere the install setp (unless cache has been clean). Although a single R version needs two jobs now.

- Even more, I find using Docker is considerable faster: previous ~4m * 3, now ~2m * 3.

As for investiging excat dependency, forget about it. From the experience of from building bookdown in last week, I learn it's better to install all common system dependency rather than debugging tons of times for each package.



# Afterword

Next morning, I tried using build stage, but find it not appropriate. Since the two jobs contain common `install` step, switch to build stage would need to _repeat_ those 4 lines of code.
