---
title: How to write easily understandable R package documentation
author: Zhuoer Dong
date: '2018-07-15'
slug: how-to-write-easily-understandable-r-package-documentation
categories: 2018
tags: []
authors: []
---


> 2020-08-19 注：忘记什么时候写完的，一直扔在 draft，今天给它放上来。

As the first step torwards open Sci, when I perfect the documentation of four R packages --- rGEO, rGEO.data, qGSEA, hgnc, I  come to establish the framework of R package documentation.

In the documentation, the core question is "What the package does". And it should be addressed in three aspects:  

  1. quick start: for impatient people who don't want to read the full documentation.  
  1. why this package: given everything already existed, why do you bother to develop this package.  
  1. summarize full functionality: for those who want to exert the full potential of your package.  

Another key point is to let user easily find what he needs without learn anything about the structure of the documentation. So I put the most important thing a freshman needs in the homepage. Even there is a "Get started" tab, I still place a "Usage" section which contains links the answer of aspects 1 & 2. In fact, as in rGEO.data and hgnc, this section is merely a link to the "Get started" page. ^[However, that doesn't means the homepage should contains explanation of every tab. First, User can explore them by themselves. Second, for a freshman, it not a big problem to not know "Reference"tab contains function reference, etc.]

The aboving three aspects can be arranged in various ways, depending on the nature of the specific package. 

For [rGEO.data](https://pkgdown.dongzhuoer.com/dongzhuoer/rgeo.data/), aspect 1 is explained in "Data" section of "Get started", aspect 2 in "Overview" section of homepage, aspect 3 in "Get started" (aspect 1 + a link to function reference).

For [hgnc](https://pkgdown.dongzhuoer.com/dongzhuoer/hgnc/), though aspect 3 is easily addressed in function reference if one has a little knowledge about that page. ^[In fact, one just need to stare the page for ten seconds, then he should know "reshape map" and "as symbol" are section header, explained by the paragraph under. Great, that two paragraph is the answer.] As I said before, you can never assume that. So I add a separate vignette ^[merged into "Get started" later] to talk about aspect 3. Aspect 1 & 2 are addressed in two sections of "Get started" page separately.
