---
title: old guide of installing texlive via ISO
date: '2018-07-03'
slug: old-guide-install-texlive-via-iso
categories: 2018
tags: []
authors: []
---



Back to the days in Nankai, I got fascinated with installing system, but the network traffic was expensive, thus Tex Live became a big problem.

I figured out a solution, i.e., install texlive via `.iso`. In this way, I could download once, install many times for both Windows and Ubuntu.

After graduate, I return home. Network traffic is no longer a problem and  I give a large partition (64G) to Ubuntu. Now `apt` seems to be the best way, it saves me a lot of trouble.

So I move the installing guide here, use on your own risk:

1. mount `texlive2016-20160523.iso`
1. `./install-tl --help`  
   to browser help instead of source code, install `perl-doc`
1. `export TEXLIVE_INSTALL_PREFIX=$HOME/texlive2016`
   `./install-tl -portable --repository http://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet`
1. move files to here and remove unneeded files (`install-tl`, `install-tl.log`, `README`, `README.usergroups`)
1. enjoy
1. remember don't move `texlive2016/x86_64-linux/bin` to `texlive2016/bin`, otherwise `texlive2016/texmf-local` & `texlive2016/texmf-var` would move to `opt/` i.e. out of `texlive2016/`. Becasue tlmgr in `texlive2016/x86_64-linux/bin` use relative path.
