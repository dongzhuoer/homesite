---
title: why is reproducible research so so so hard?
date: '2017-10-22'
slug: why-repro-research-so-hard
categories: 2017
tags: []
authors: []
---



这是跟着 Gao 老师远程实习，做 gene loss 的事了。我得到了两个表格，想比较一下是不是完全一样的。

其中部分内容分别为：


```
# A tibble: 7 x 10
     X1             X2    X3       X4       X5    X6    X7    X8              X9   X10
  <int>          <chr> <int>    <int>    <int> <chr> <int> <int>           <chr> <chr>
1   165 LOC_Os11g48060     4 57749194 57750836     +     2     0 relic-retaining   sbi
2  4397 LOC_Os02g08140     3 47955604 47956683     +     1     0 relic-retaining   sbi
3  5146 LOC_Os03g10940     1  6133765  6136732     -     1     0 relic-retaining   sbi
4  8968 LOC_Os02g52510     4 63921086 63928674     -     2     0 relic-retaining   sbi
5  9435 LOC_Os12g18650     6 49944588 49946702     -     2     0 relic-retaining   sbi
6 10318 LOC_Os01g74500     3 74386656 74396272     +    NA    NA   relic-lacking   sbi
7 16364 LOC_Os01g55549     3 63381108 63384547     -     4     0 relic-retaining   sbi
```

和

```
# A tibble: 7 x 10
          ID   chr    start      end strand frameshift `preliminary stop-codon` `orthologous group` `orthologous counterpart`
       <chr> <dbl>    <dbl>    <dbl>  <chr>      <chr>                    <chr>               <dbl>                     <chr>
1 Sor_chr4_2     4 57749194 57750836      +          2                        0                 165            LOC_Os11g48060
2 Sor_chr3_1     3 47955604 47956683      +          1                        0                4397            LOC_Os02g08140
3 Sor_chr1_3     1  6133764  6136732      -          1                        0                5146            LOC_Os03g10940
4 Sor_chr4_3     4 63921085 63928674      -          2                        0                8968            LOC_Os02g52510
5 Sor_chr6_1     6 49944587 49946702      -          2                        0                9435            LOC_Os12g18650
6 Sor_chr3_4     3 74386656 74396272      +         NA                       NA               10318            LOC_Os01g74500
7 Sor_chr3_2     3 63381107 63384547      -          4                        0               16364            LOC_Os01g55549
```

I once thought `start` or `paste(start, end)` would be a good ID, but it turned not. So I had to use `orthologous group` as ID to process the data.

为什么有些行的 `start` 一模一样，另一些却正好差 1？

这两个表格具体是什么已经不重要了，应该一个是师兄的结果，一个是我重复的结果。重要的是差异为何如此奇葩，可重复性科研为什么就如此如此如此之难？
