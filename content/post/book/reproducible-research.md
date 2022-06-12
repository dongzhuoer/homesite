---
title: Reproducible Research
date: '2019-12-27'
slug: reproducible-research
categories: book
tags:
  - book-program
  - book-research
authors: []
---



> Reproducible Research 不是拿来主义，一味降低难度反而会培养伸手党，currently we assume user 受过高等教育。

How can my paper stay alive, rather than dead on day of publishing? Here **alive** means others spend little effort while enjoy substantial benefit in using it.



# readme

We assume user would read `readme.md` before using the software (I prefer "Installation" title).

I won't explain everything, for example, user is supposed to know `install.packages("blogdown")` should be executed in R terminal. Luckily, the second result when you Google `install.packages` leads to a detailed tutorial with screenshots.



# automatic

Another way is to automatically install dependencies when user run the software. Actually I haven't come out a fair solution yet.

Convenient as it seems, someone heats changing their runtime environment. 

Currently, I assume user would run my workflow step by step, so I just put the installation code on the top. The code is configured to _only_ run in CI environment such as Travis (`CONTINUOUS_INTEGRATION=true`), as I don't want to waste time on my computer (`install_github()` still runs even if the packages is already installed).
