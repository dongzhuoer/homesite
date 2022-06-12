---
title: bioconductor 包的教程还是一如既往的烦
date: '2018-12-16'
slug: bioconductor-vignette-annoy-me-as-usual
categories: 2018
tags: []
authors: []
---



今天下午在看一个 Bioconductor 包的 [vignette](https://www.bioconductor.org/packages/release/workflows/vignettes/simpleSingleCell/inst/doc/work-1-reads.html)，做 single cell 分析的。

我发现我现在真是对 `read.delim()` 之流充满了厌恶。还有 `library(SingleCellExperiment)` ，要等几秒就不说的，还把我的 R seession 搞得像爆炸了一样。

具体来说，我觉得这个教程中不好的地方是：

1. 真逗，你还不运行了啊，就不会按名称 join 吗？

   ```r
   m <- match(colnames(sce), metadata[["Source Name"]]) # Enforcing    identical order.
   stopifnot(all(!is.na(m)))
   ```

1. 坑，你确定原始的 character 转化为 factor 后的 level 一定是你指定的这样？

   ```r
   levels(pheno) <- c("induced", "control")
   ```


> 可重复性不仅仅是别人能跑，还要让代码简洁易懂，要有可扩展性。

最后吐槽一下，还 simpleSingleCell，光是一个 vignette 就这么臭长了，总共有10篇vignette，谁想学啊？顺便立个flag，希望我写的 thesis 的 4个 R 包的文档，能让读者学的时候能真正感到 _simple_ 。

--------------------------------

附一下代码（写了几个钟头，就这么删掉太可惜了）：

````
---
title: "Analyzing single-cell RNA-seq data containing read counts"
output: html_document
---


`r ''````{r}
bfc <- BiocFileCache::BiocFileCache("raw_data", ask = FALSE)

lun.zip <- BiocFileCache::bfcrpath(
    bfc, 
    file.path("https://www.ebi.ac.uk/arrayexpress/files", "E-MTAB-5522/E-MTAB-5522.processed.1.zip")
)
lun.sdrf <- BiocFileCache::bfcrpath(
    bfc, 
    file.path("https://www.ebi.ac.uk/arrayexpress/files", "E-MTAB-5522/E-MTAB-5522.sdrf.txt")
)

unzip(lun.zip)
```


`r ''````{r message=FALSE, warning=FALSE}
plate1 <- readr::read_tsv("counts_Calero_20160113.tsv")
plate2 <- readr::read_tsv("counts_Calero_20160325.tsv")
plate <- dplyr::inner_join(plate1, plate2)

meta_data <- readr::read_tsv(lun.sdrf) %>% 
    dplyr::select('cell' = 'Source Name', 'plate' = 'Factor Value[block]', 
                  'pheno' =  'Factor Value[phenotype]') %>%
    dplyr::mutate(plate = factor(plate)) %>%
    dplyr::mutate(induced = stringr::str_detect(pheno, 'induced')) %>%
    dplyr::mutate(oncogene = ifelse(induced, 'induced', 'control')) %>%
    dplyr::mutate(oncogene = factor(oncogene, c('induced', 'control')))

gene_length <- plate$Length;
count_df <- plate[, -2] %>% as.data.frame() %>% tibble::column_to_rownames('GeneID')
meta_data %<>% dplyr::left_join(tibble::tibble(cell = colnames(count_df)), .) # reorder

sce <- SingleCellExperiment::SingleCellExperiment(
    assays  = list(counts = as.matrix(count_df)),
    rowData = list(GeneLength = plate$Length, ENSEMBL = rownames(plate)),
    colData = list(Plate = meta_data$plate, Oncogene = meta_data$oncogene)
) %T>% print
```



`r ''````{r}
# remove another set of spike-in transcripts, the Spike-In RNA Variants (SIRV) set
sce = sce[!stringr::str_detect(rownames(sce), '^SIRV'), ]

SingleCellExperiment::isSpike(sce, 'ERCC') <- stringr::str_detect(rownames(sce), '^ERCC')
```


`r ''````{r message=F}
SummarizedExperiment::rowData(sce)$SYMBOL <- AnnotationDbi::mapIds(
    org.Mm.eg.db::org.Mm.eg.db, keys = rownames(sce), keytype = "ENSEMBL", column="SYMBOL"
)
```

````
