---
title: testthat mask potential bug of not import %>% from magrittr
author: Zhuoer Dong
date: '2018-11-13'
slug: testthat-indulge-not-import-pipe
categories: 2018
tags: []
authors: []
---



**magrittr** is a wonderful package, but the biggest drawback is that you can't write `magrittr::%>%`.

That can cause _great_ pain in package development, I spend a whole morning to debug.

Basically, I summary the following rules:

- **testthat** ignores `.Rprofile`
- In theory, every pipe operator used _must_ be imported from magrittr
- except for `%>%` (testthat import and export it)


```r
testthat::`%>%`
```
```
function (lhs, rhs) 
{
    lhs <- substitute(lhs)
    rhs <- substitute(rhs)
    kind <- 1L
    env <- parent.frame()
    lazy <- TRUE
    .External2(magrittr_pipe)
}
<bytecode: 0x55f41f0b2c58>
<environment: namespace:magrittr>
```
