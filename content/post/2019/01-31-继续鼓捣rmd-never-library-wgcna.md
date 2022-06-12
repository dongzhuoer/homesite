---
title: 继续鼓捣 .Rmd, 打死我也不会 library (WGCNA) 的
date: '2019-01-31'
slug: never-library-wgcna
categories: 2019
tags: []
authors: []
---



```{r install-pkg, message=FALSE, eval=Sys.getenv('CI') == 'true'}
# install needed R packages
remotes::update_packages(c('magrittr', 'callr', 'purrr', 'rlang'), upgrade = TRUE)
```

# Beginning

这几天都在整理前两轮轮转的 `.Rmd`, 使其完全可重复，于是又把 [lncRNA network analysis](https://github.com/dongzhuoer/lulab-rotation-summary/blob/master/RNA-seq/lncRNA-co-expr-net.md) 翻出来了

之前发现运行失败就直接 library() 了，现在要统一标准，又改成 :: 来调用。

```
Error in (function (x, y = NULL, use = "everything", method = c("pearson", : unused arguments (weights.x = NULL, weights.y = NULL, cosine = FALSE)
```

# Development

这次我就查了下错误原因，好像是 `cor()` 本来应该调用 `WGCNA::cor()`，结果调用了 `stats::cor()` （难怪 `library()` 就好了，因为后者覆盖了前者）

很奇怪，我以前写包没遇到啊。

Anyhow, I try `detach('package:stats')`, still fail

I search the source code, find WGCNA use `get('cor', envir = envir)` to get the `cor()` function, so `'package:WGCNA'` must be listed in the search path (and before `'package:stats'`).

Sticking to `::`, I decide to use `callr::r()`

```r
WGCNA_blockwiseModules <- function(..., .show = TRUE) {
    callr::r(
        function(...){
            library(WGCNA)
            allowWGCNAThreads()
                
            # you can directly run following code in current session after `library(WGCNA)` 
            blockwiseModules(...)
        }, args = list(...), show = .show
    )
}

# it takes about 4m
network <- WGCNA_blockwiseModules(
    fpkm_t, power = soft_threshold$powerEstimate, 
    maxBlockSize = 7000, TOMType = "unsigned", 
    minModuleSize = 30, reassignThreshold = 0, mergeCutHeight = 0.25, 
    numericLabels = TRUE, pamRespectsDendro = FALSE, saveTOMs = FALSE, verbose = 3
)
```

# Climax

Addicted to quasiquotation, I want this helper function to print the executed code like [`rexseek::norm_tmm()`](`r blogdown::shortcode('relref', '01-28-rexseek-stand-up-abandon-scater.html#climax')`). But this case is more difficult, since the parameter is `...`, and more importantly the code is evaluated by `callr::r()`.

Finally I come out with the following code:

```{r}
WGCNA_blockwiseModules <- function(...) {
    main_expr <- rlang::expr(blockwiseModules(!!!rlang::exprs(...)))
    exprs <- rlang::exprs(library(WGCNA), allowWGCNAThreads(), !!main_expr)    
    data <- as.list(rlang::caller_env());
    
    network <- callr::r(
        function(exprs, data) {purrr::map(exprs, rlang::eval_tidy, data = data)}, 
        args = list(exprs, data)
    )[[3]]

    message('\nI use callr to avoid messing the workspace, you can run the following code yourself:\n')
    exprs %>% sapply(rlang::expr_text) %>% sapply(message)
    return(network)
}
```

The most difficult part is passing the environment to `rlang::eval_tidy()`. At first thought, I think it's fairly simple with `rlang::caller_env()`, but it doesn't work, latter I find that inside `callr::r()`, the captured environment mysteriously becomes global environment. Then I convert the environment to a list and use data mask, this time it works.

This case reveals some internal of quasiquotation. Actually, it's quite reasonable, since `callr::r()` provides a mechanism to execute code is a _seperate_ session. Write/read `.rds` is a useful implementation to pass oridnary objects as arguments, but environment is somehow different, you can track along the parents and arrive the current workspace, which is definitely forbidden.

Looking at the helper function, I fully understand there are some limitation, passing symbols has no problem, while complicated syntax generate issues (like lazy eval, call stack). But those price is necessary for isolating `WGCNA::blockwiseModules()` inside a independent session.



# Epilogue

However, the biggest problem is that I won't even use it since it takes a long time. That is to say, all my effort is nearly wasted. 

So I write this post, and provide the following toy example to demonstrate the helper function.

```r
library(magrittr)

expr_data <- matrix(rpois(100, 10), nrow=10) + 0 # `+ 0` turns integer into numeric 
network <- WGCNA_blockwiseModules(
    expr_data, power = 10, 
    maxBlockSize = 7000, TOMType = "unsigned", 
    minModuleSize = 30, reassignThreshold = 0, mergeCutHeight = 0.25, 
    numericLabels = TRUE, pamRespectsDendro = FALSE, saveTOMs = FALSE, verbose = 3
)
## 
## I use callr to avoid messing the workspace, you can run the following code yourself:
## library(WGCNA)
## allowWGCNAThreads()
## blockwiseModules(expr_data, power = 10, maxBlockSize = 7000, 
##     TOMType = "unsigned", minModuleSize = 30, reassignThreshold = 0, 
##     mergeCutHeight = 0.25, numericLabels = TRUE, pamRespectsDendro = FALSE, 
##     saveTOMs = FALSE, verbose = 3)

network
## $colors
##  [1] 0 0 0 0 0 0 0 0 0 0
## 
## $unmergedColors
##  [1] 0 0 0 0 0 0 0 0 0 0
## 
## $MEs
##           ME0
## 1   0.1320520
## 2  -0.1145554
## 3  -0.1744860
## 4   0.2848684
## 5  -0.1471451
## 6   0.3766016
## 7  -0.4780682
## 8  -0.2063703
## 9  -0.2664064
## 10  0.5935093
## 
## $goodSamples
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## 
## $goodGenes
##  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
## 
## $dendrograms
## $dendrograms[[1]]
## 
## Call:
## fastcluster::hclust(d = as.dist(dissTom), method = "average")
## 
## Cluster method   : average 
## Number of objects: 10 
## 
## 
## 
## $TOMFiles
## NULL
## 
## $blockGenes
## $blockGenes[[1]]
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## 
## $blocks
##  [1] 1 1 1 1 1 1 1 1 1 1
## 
## $MEsOK
## [1] TRUE
```
