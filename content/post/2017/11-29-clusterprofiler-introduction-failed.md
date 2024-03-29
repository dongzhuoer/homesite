---
title: clusterProfiler introduction failed, 发布之日即是死亡之日
date: '2017-11-29'
slug: clusterprofiler-introduction-failed
categories: 2017
tags: []
authors: []
---



这篇旧博客写的本是一篇介绍 clusterProfiler 的文章失效的事，但我后来整理时回想起来我以前说过的一句话：

> The day a research project is published shouldn't be the day it's dead.

--------------------------------------

Original post: [use clusterProfiler as an universal enrichment analysis tool](https://guangchuangyu.github.io/2015/05/use-clusterprofiler-as-an-universal-enrichment-analysis-tool/)

But things allways change

1. data link broke

    http://www.disgenet.org/ds/DisGeNET/results/all_gene_disease_associations.tar.gz should be replaced by http://www.disgenet.org/ds/DisGeNET/results/all_gene_disease_associations.tsv.gz

1. use `tibble::as_tibble()` instead of `DOSE::summary()`
    
    ```r
    Warning message:
    In DOSE::summary(edn) :
      summary method to convert the object to data.frame is deprecated, please use as.data.frame instead.
    ```

1. `clusterProfiler::GSEA()` failed

Following is updated code:

```r
data("geneList", package = 'DOSE');
deg <- geneList %>% {names(.)[abs(.) > 2]};

agda <- readr::read_tsv('all_gene_disease_associations.tsv.gz');
disease2gene <- dplyr::select(agda, 'diseaseId', 'geneId');
disease2name <- dplyr::select(agda, 'diseaseId', 'diseaseName');

e <- clusterProfiler::enricher(deg, TERM2GENE = disease2gene, TERM2NAME = disease2name);
tibble::as_tibble(e);

DOSE:::barplot.enrichResult(e);
DOSE::dotplot(e);
DOSE::enrichMap(e);

g <- clusterProfiler::GSEA(geneList, TERM2GENE = disease2gene, TERM2NAME = disease2name);
tibble::as_tibble(g)
```
