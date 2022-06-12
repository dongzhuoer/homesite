---
title: lobstr segfault leads me to develop a way to debug `rmarkdown::render()`
date: '2018-12-20'
slug: debug-rmarkdown-render
categories: 2018
tags: []
authors: []
---



# cause

My copy of _adv-r_ seems to have some problem in chapter cross-reference, so I decide to build the source code to figure out the cause.

Then the build failed —— a very serious error which corrupts R session and forces me exit.


# Development

Naturally, I want to find where the error occur, but the `unnamed-chunk-***` in `rmarkdown::render()` console output is so annoying! Who can ever know which chunk is the `***`st chunk ?!

As I expected, **knitr** doesn't provide the API to get nth chunk (I should have tried this several times).


# Climax

Then I start to think about set something in knitr, so that every chunk's code would be printed in the console output. I read the knitr book, tried many times, and finally find a way when I am going to give up: 

    `r ''````{r}
    old_chunk_hook <- knitr::knit_hooks$get('chunk')
    new_chunk_hook <- function(x, options) {
        writeLines(options$code)
        old_chunk_hook(x, options)
    }
    knitr::knit_hooks$set(chunk = new_chunk_hook)
    knitr::opts_chunk$set(mutable_var = Sys.time()) # disable cache
    ```

Now I can search the code causing error, which seems really wired: calling `lobstr::obj_size()` with function, such as `mean`, would cause segfault. (As usual, I run it yesterday!)


# Epilogue

Finally, `eval = F` that chunk, build the book, and find the reason: the cross-reference failure seems to result from `split_by: section`.


# Afterword

Recall that I happily discard **microbenchmark** after I find **bench** is awesome to use in the mooning, now I should say it's so fortunate that we have **pryr** in hand when lobstr fails oddly.
