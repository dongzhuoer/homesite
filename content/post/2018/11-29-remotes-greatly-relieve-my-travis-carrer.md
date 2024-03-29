---
title: remotes, a small step of devtools suite, a big step for my Travis carrer
date: '2018-11-29'
slug: remotes-greatly-relieve-my-travis-carrer
categories: 2018
tags: []
authors: []
---



# Beginning

Back to my graduate year, I set up Travis to automatically test my R packages.



# Development

**devtools** is a good tools, but there are a few issues:

1. `install_bioc()` only works well in development version 
1. even that, `install_bioc()` would promote you to _type_ `y` to install **BiocInstaller**. But it's hard to response to that, since Travis CI is automatic. So I have to manually install BiocInstaller before calling it.
1. Due to a misunderstanding [^remotes-misconception], only in development version can `install_github()` & `install_local()` install dependencies on GitHub 



# Climax

The newly release version of **remotes** works very nice. (**devtools** is splited, `install_*()` is moved to **remotes** and exported back)

It just needs Git on your system (no **BiocInstaller** at all), and it's very lightweight, only needs severval seconds to install.


# Afterword

By the way, the new **BiocManager** is also very nice. You can install it as a normal CRAN package, no more `source("https://bioconductor.org/biocLite.R")` (The damn network speed never troubles me any more, 何以解忧，唯有镜像.)


[^remotes-misconception]:
    It's a misconception started before the first I use R on Travis, the exact point should be the first time that I write `Remotes` in `DESCRIPTION`. At that time, I think I just need to specify GitHub packages in `Remotes`. But devtools doesn't install these packages, I even switch to Github version of devtools. 

    Thanks to this [SO answer](https://stackoverflow.com/questions/44267268#answer-44269045), I know that I have to both specify package location in `Imports` and add package name in `Depends`. Acutally, all I need to avoid the caveat is to read the [official documentation](https://mirrors.tuna.tsinghua.edu.cn/CRAN/web/packages/devtools/vignettes/dependencies.html):
    
    > You can mark any regular dependency defined in the Depends, Imports, Suggests or Enhances fields as being installed from a remote location by adding the remote location to Remotes in your DESCRIPTION file.

    注：原文来自 2018-06-03 的 post：It's me rather than devtools who is wrong | 错的并不是devtools，而是我
