---
title: dput() reveal the secret behind S3 class
author: Zhuoer Dong
date: '2018-12-21'
slug: dput-disclose-s3-class-secret
categories: 2018
tags: []
authors: []
---


> The rotation project in Zhang Lab gives me reason and time to master Rcpp


# Beginning

```r
library(magrittr)
```


After learning the basics of Rcpp, I can't wait to chieve something. When a C++ function needs to return a `data.frame`, I decide that rather than `DataFrame`, I want to return a `tibble`.


# Development

I think it's a small dish, since "Advanced R" already teaches me how to add attributes.

```r
tibble::tibble(x = 1:2) %>% attributes()
```
```
## $class
## [1] "tbl_df"     "tbl"        "data.frame"
## 
## $row.names
## [1] 1 2
## 
## $names
## [1] "x"
```

I assume the following code is enough:

```cpp
auto x = IntegerVector::create(1, 2);
auto df = List::create(Named("x") = x;

df.attr("class") = CharacterVector::create("tbl_df", "tbl", "data.frame");
df.attr("row.names") = IntegerVector::create(1, 2);
```

But actually it's NOT (note the `*`)

```
# A tibble: 2 x 2
  a         b
* <chr> <int>
1 23        1
2 hao       2
```

Then I tried to not set `df.attr("row.names")`, and get a 0 row `tibble`.

Finally I give up and use a R function wrapper to convert `data.frame` to `tibble`.



# Climax

Some days later, I find the secret

```r
tibble::tibble(x = 1:2) %>% dput()
```
```
## structure(list(x = 1:2), class = c("tbl_df", "tbl", "data.frame"
## ), row.names = c(NA, -2L))
```

My God, `df.attr("row.names")` should be `IntegerVector::create(NA_INTEGER, -2)`, whoever can know that?


# Afterword

The point of this story is no matter how complicated an object is, you can always inspect the secret by `dput()` .



