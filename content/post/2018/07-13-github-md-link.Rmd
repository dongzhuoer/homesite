---
title: link to .md file on GitHub
author: Zhuoer Dong
date: '2018-07-13'
slug: github-md-link
categories: 2018
tags: []
authors: []
---


# Beginning

Yesterday, when writing documentation for undergraduate thesis R packages, I wanted to utilize cross-link to improve readability.

In some place ^[Unfortunately I forget where it is when I revise this post on 2019-03-05.], I wanted to add a link which can jump a specific text in https://github.com/dongzhuoer/rGEO.data/blob/master/R-raw/data.Rmd :

```markdown
`gds_result.txt`: click [here](https://www.ncbi.nlm.nih.gov/gds?term=(%22expression%20profiling%20by%20array%22%5BDataSet%20Type%5D)%20AND%20%22homo%20sapiens%22%5BOrganism%5D).
    Or query `("expression profiling by array"[DataSet Type]) AND "homo sapiens"[Organism]`
    in [GEO DataSets](https://www.ncbi.nlm.nih.gov/gds). 
```

I tried for a while, found it's not easy and endwd up with `search gds_result.txt in here`.


# Development

Today, I realize user won't bother to select, copy, click, paste search, so I 'd better provide a link which user can just click.

Thanks to this [doc](https://help.github.com/articles/searching-code/), I wrote a url perfoming advanced search on GitHub: https://github.com/search?q=gds_result.txt+repo%3Adongzhuoer%2FrGEO.data+filename%3Adata.Rmd+path%3A%2FR-raw . It would query `gds_result.txt repo:dongzhuoer/rGEO.data filename:data.Rmd path:/R-raw`. As you can see, by specifying repo and path, the url can precisely locate to the expected position. However, the display is just not what I desired. The lines following the displayed paragraph is collapsed in `...` and you can't expand it by click. After you click the file, you will just get a normal webpage (only display the head of the file), with no means to highlight the part I desired. 

Then I try to link to specific line (range) ^[https://help.github.com/articles/creating-a-permanent-link-to-a-code-snippet/ helps a lot.], but that doesn't work either. On one hand, if I only specify line number, the file content may change in future and link to the wrong place; On the other hand, If I use permanent link, although the link is always valid, user can't see the latest description of `gds_result.txt`.


# Climax

In the final solution, I have to use the ugly syntax of `<code id=gds_result.txt>gds_result.txt</code>` and use `#user-content-gds_result.txt` to refer that anchor. 

Desperately, it still doesn't work, the page still not jump to that location after refreshing. When I am going to give up, I find it actually _works_ if I open a new tab. The problem lies in refreshing: the page would retain the same position before.


# Epilogue

Anyway, HTML tag isn't elegant. I plan to tidy the structure of the file and add appropriate heading.
