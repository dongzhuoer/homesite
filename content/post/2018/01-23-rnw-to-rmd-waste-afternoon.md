---
title: Rnw to Rmd waste another afternoon
date: '2018-01-23'
slug: rnw-to-rmd-waste-afternoon
categories: 2018
tags: []
authors: []
---



# Beginning

When I read the docmentation of **SeqGSEA**, I get furious at the prompt (`>`):

```r
> rcounts <- cbind(t(sapply(1:10, function(x) {rnbinom(5, size=10, prob=runif(1))} )),
+                  t(sapply(1:10, function(x) {rnbinom(5, size=10, prob=runif(1))} )))
> colnames(rcounts) <- c(paste("S", 1:5, sep=""), paste("C", 1:5, sep=""))
> geneIDs <- c(rep("G1", 4), rep("G2", 6))
> exonIDs <- c(paste("E", 1:4, sep=""), paste("E", 1:6, sep=""))
> RCS <- newReadCountSet(rcounts, exonIDs, geneIDs)
> RCS
```

So I decided to convert the `.Rnw` source file into `.Rmd`.


# Development

First, someone kindly recommend me to use this workflow: `.Rnw` -> `.tex` -> `.md`. 

After `results='hide'` and `highlight=TRUE`, most content seems fine, but there are still a few serious problems.


# Climax


If you see `\newcommand{\Rpackage}[1]{{\textit{#1}}}`, then `\Rpackage{SeqGSEA}` should be `**SeqGSEA**`. However, it's very hard to convert every custom command perfectly.


To make things worse, all chunk options were dropped, and it's very hard to recover. For example, you need to construct `fig.align='center', out.width='95%', fig.cap='Gene scores ... data sets.'` from the following output:

```
\begin{figure}
\centering
\includegraphics[width=0.6\textwidth]{SeqGSEA-genescore_l}
\caption{Gene scores ... data sets.}
\label{fig:gsl}
\end{figure}
```


# Epilogue

I started the work at about 14:30pm and wrote the post at about 17:12pm. In the interval, I almost rewrote the whole document.

In the process, I realized that parsing output is really wasting time, such as converting `.pdf` to `.docx` by Foxit PDF Editor. That might be the reason why the author of **knitr** hasn't write a `Rnw2Rmd()` function.
