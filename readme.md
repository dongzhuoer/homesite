# Zhuoer Dong's personal website
[![Build Status](https://travis-ci.com/dongzhuoer/homesite.svg?branch=master)](https://travis-ci.com/dongzhuoer/homesite)
[intermediate](https://gitlab.com/dongzhuoer/homesite-hugo)
[![Netlify Status](https://api.netlify.com/api/v1/badges/5227017d-d925-4490-b603-7214251b94bb/deploy-status)](https://app.netlify.com/sites/zhuoer/deploys)



## Overview

This blog mainly consists of two parts:

- book: some tutorial, might move to _nutshell_ in the future
- caprice: 随想 & 编程杂谈——我就是这样一个善变的人



## Installation

1. install [Hugo](https://github.com/gohugoio/hugo)
1. `remotes::install_local()`



## Usage

```r
blogdown::build_site(local = TRUE, build_rmd = blogdown::filter_md5sum)
```

- siderbar Taxonomy both tags and category [https://github.com/MunifTanjim/minimo/issues/305]



## Developers

```bash
Rscript -e 'blogdown::new_post("你好，世界", open = F, categories = "2021")'
Rscript -e 'file.remove( dir(here::here("content"), "\\.html$", full = T, recursive = T) )'
rm -r public/*
```

post (`.md`) 都位于 `content/post/` 下:
- book post (和 `_index.md` 一起) 位于 `content/post/book/`，</post/book/index.html> 就会自动变成 index page
- caprice post （按年份组织）位于 `content/post/`，</post/index.html> 就会自动变成 index page （由于 `book/` 子目录有 `_index.md`，所以其包含的 post 不会显示在该页面）
这种组织方式对于其它 theme 也是适用的，比如 [hugo-lithium](https://github.com/yihui/hugo-lithium)



## post structure

1. Preface
1. Beginning
1. Development
1. Climax
1. Epilogue
1. Afterword



## Sponsorship

This website is hosted by **[Netlify](https://www.netlify.com/)**.



-----------------------
[![Creative Commons License](https://i.creativecommons.org/l/by-nc/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc/4.0/)  
This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](http://creativecommons.org/licenses/by-nc/4.0/)
