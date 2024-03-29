---
title: evolution of R package on travis
date: '2018-06-02'
slug: r-package-travis-evolution
categories: 2018
tags: []
authors: []
---



# Preface 

This post was written before [the introduce of Docker](/post/docker-testthat-on-travis/) on 2018-12-09.


# Introduction

For me, the most benefit of mastering Travis CI is to test R packages. 

This post aims to provide some explanation for my `.travis.yml`, focusing on how the code evolves.

I will arrange things according to different parts, though a time order may present the relationship between them better.


# purpose

The core rational is that ensure user can successful install my package rather than that I can successfully build it. 

Although the general purpose of a CI is to test the program can be built and works as aspect, I want to go further and make sure there won't be any additional problems when user install my package.


# workflow

The first version is adopted from [official workflow](https://docs.travis-ci.com/user/languages/r/#Customizing-the-Travis-build-steps):

```yaml
before_install:
  - R -e "r_package <- c('devtools', 'roxygen2', 'testthat'); lapply(r_package, function(x) {if (!(x %in% .packages(T))) install.packages(x)})"
install:
  - R -e 'devtools::install_deps(dep = T, upgrade = T)'
script:
  - R -e 'devtools::document()'
  - R CMD build .
  - R -e "if (dir.exists('tests/testthat')) devtools::test()"
```

Then I use `devtools::install_local()` to make it more similar to `devtools::install_github()` which user would use:

```yaml
before_install:
  - R -e "r_package <- c('devtools', 'roxygen2', 'testthat'); lapply(r_package, function(x) {if (!(x %in% .packages(T))) install.packages(x)})"
script:
  - R -e "devtools::install_local(getwd())"
  - R -e "devtools::update_packages('testthat'); if (dir.exists('tests/testthat')) devtools::test()"
```


# version and platform

One advantage of R language by Travis community is multiple versions on multiple platforms:

```yaml
language: r
os: [linux, osx]
r: [release, devel, oldrel]
matrix:
  fast_finish: true
  allow_failures:
  - r: devel
  - r: oldrel
```

We can skip  `devel` and `oldrel` on OS X to save time (`include` would use first value as default, that means `devel` and `oldrel` are only added for `linux`):

```yaml
language: r
os: [linux, osx]
r: release
matrix:
  include:
    - r: devel
    - r: oldrel
```



# clean cache

> If tests run for more than 10 minutes, developers will often start a new task rather than wait for the tests to finish. If the tests then fail, the developer now has to switch back to the original task. Constantly switching between tasks dramatically reduces productivity. 
>
> --- https://eng.localytics.com/best-practices-and-common-mistakes-with-travis-ci/

Caching installed package saves a lot of time, but brings the need to clean it periodically.

In the beginning, I clean cache via (monthly) cron build:

```yaml
before_install:
  - R -e "if (Sys.getenv('TRAVIS_EVENT_TYPE') == 'cron') unlink(dir(.libPaths()[1], full.names = T), recursive = T)"
```

Later I use cron job to continuously build my package weekly, so I check if the date is the first week to clean cache monthly:

```yaml
before_install:
  # combined with a weekly cron job, package cache would be updated monthly
  - R -e "if (as.integer(substr(Sys.Date(), 9, 10)) < 8 && Sys.getenv('TRAVIS_EVENT_TYPE') == 'cron') unlink(dir(.libPaths()[1], full.names = T), recursive = T)"
```

As the R packages become more and more, I decide to clean cache quarterly [^quarterly] (first week of first month of each quarter)

```yaml
before_install:
  - if [ "$TRAVIS_EVENT_TYPE" == "cron" ]; then R --slave -e "date <- Sys.Date(); day <- as.integer(substr(date, 9, 10)); month <- as.integer(substr(date, 6, 7)); clean <- month %% 3L == 1L && day <= 7L; if (clean) unlink(dir(.libPaths()[1], full.names = T), recursive = T)"; fi;
```

[^quarterly]: The R code during development is:
    ```r
    date <- as.Date('2018-04-06') #Sys.Date()
    day <- as.integer(substr(date, 9, 10))
    month <- as.integer(substr(date, 6, 7))				  

    clean <- month %% 3L == 1L && day <= 7L
    clean
    ```
