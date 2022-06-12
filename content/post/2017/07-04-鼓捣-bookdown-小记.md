---
title: 鼓捣 bookdown 小记
date: '2017-07-04'
slug: 鼓捣-bookdown-小记
categories: 2017
tags: []
authors: []
---



> 刚接触 **bookdown** 时，鼓捣了好久，这里记一下。

- `documentclass: book` tells `pandoc` that the first-level headers should be treated as chapters instead of sections. If you change `documentclass`, you may need to specify an additional `pandoc` argument, `--chapters`

- To disable MathJax, you need to set `math: false` in `index.Rmd`.

- `bookdown::gitbook()` storage configurations in `$post_processor()`, only this function can assess the `gh_config` object.

- When your `.Rmd` contains Chinese, you need to call `rmarkdown::render(encoding = 'UTF-8')`, but you mustn't set `options(encoding = 'UTF-8')`.
