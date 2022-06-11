---
title: Encounter Travis, automatically build PDF
author: Zhuoer Dong
date: '2018-02-11'
slug: first-travis-auto-build-pdf
categories: 2018
tags: []
authors: []
---


# Preface

本以为要到学完 Python 之后专门抽时间对付 Travis 的，结果一不小心花了一晚上就给灭了 ^[当然还有很多要学的，不过至少已经可以用它来完成任务了。]。


# Beignning

当时在准备留学，中介建议我用 LaTex 写暑研的简历，然后我就想把 `.tex` 放到 GitHub 上。


# Development

> 电子邮件是人类进步的克星
> 
> --- Yihui Xie

GitHub 虽然大大方便了协作开发，但多人开发终归还是藏坑无数 ^[你的代码基本上只能活在你的电脑上。]。为了避免以后为配置环境而浪费时间，不如干脆现在就启用 Travis CI。


其实生成 PDF 倒不难，关键是我想把生成的 PDF 放在 GitHub 上（不是 release）。对于个人简历这种小文件而言，GitHub 的预览还是蛮给力的。因而我就开始研究各种 deploy 的黑魔法，简直快要崩溃了。


# Climax

直到我突然意识到，远在天边、近在眼前。其实我只需要让 Travis `git add + commit + push` 就好了。

说起来容易，做起来就幺蛾子不断了。首先是被斩首了 ^[细节我就不说了，就像在稻草堆中找一根针还不给光，最后请出了磁铁大人—— `git branch -v`，一切瞬间就清晰了。]，然后是 Travis 的 deploy key 只读 ^[之前查到的 GitHub token 访问 repo 的资料很自然地派上用场了]，好不容易才弄好。

现在每次 commit 都会自动生成 PDF 放到 GitHub 代码库中。pull request 也有，不过稍微麻烦一点，要先点开 branch ^[Add more commits by pushing to the *** branch on user/repo ]，因为文件在想要 merge 的 commit 的后面的一个 commi t中，所以不能在 pull request 页面中直接找到。


# Epilogue

目前最佳的用法是：

- 如果直接在网页版做修改的话，建一个新的 branch 来发起 pull request （只有库的维护者才能发起 ^[我把 GitHub token 设置成了加密的环境变量，根据[文档](https://docs.travis-ci.com/user/pull-requests/#Pull-Requests-and-Security-Restrictions), 只有我自己的库的 pull request 才能访问加密的环境变量。]） 会好一点，这样能方便地看到修改的地方、预览修改后的 PDF 以及讨论修改意见。
- 如果改动很多，比起分支、合并之类的高级操作，不如用 `git clone` 到本地来修改后直接 `commit` 到`master`。


# Afterword

写于 2019-02-28：尽管中介给我配的老师（其实就是在读博士生）是 CS 专业的，但是我们最后还是用 Email 和微信来交流修改意见，到最后我自己也没怎么用这个库。不过这次的经验倒是为我以后 build bookdown book + deploy to GitLab repo 奠定了基础。





