---
title: what's the feeling of compiling R by oneself?
date: '2017-12-02'
slug: compile-r
categories: 2017
tags: []
authors: []
---



> （2019-12-12）多年以后真正需要 compile 时， 放狗一搜，人家早就把[教程](https://support.rstudio.com/hc/en-us/articles/215488098)准备好了。只需要一行命令，`sudo apt-get build-dep r-base`，就全部搞定了。不过我还是犯了一定要挑选最合适 option 的老毛病，最终确定为`./configure --prefix=$HOME/.local/R-3.6.1 --with-blas --with-lapack --enable-memory-profiling`。   

> 当时正是钻研鸟哥的时候，Ubuntu 自带的 R 有点旧，我又没找到好用的添加 apt repository 的教程，于是就开始尝试自己编译 R。果然问题百出，不过最后好容易完成的时候，还挺有成就感的。



# `R.sh`

```bash
#!/bin/bash

#depends : jdk, texlive, build-essential 
tlmgr install inconsolata times courier helvetic ec xkeyval texinfo

# alternately, install r-base-dev
apt-install gfortran
apt-install zlib1g-dev libbz2-dev liblzma-dev libpcre3-dev libcurl4-openssl-dev
apt-install libreadline-dev      # --with-readline
apt-install libcairo2-dev        # --with-cairo 
apt-install libpng-dev           # --with-libpng
apt-install libjpeg-dev          # --with-jpeglib
apt-install libtiff5-dev         # --with-libtiff
apt-install libtre-dev           # --with-system-tre 
apt-install libicu-dev           # --with-ICU
apt-install libxt-dev            # --with-x
apt-install texinfo              # build info or HTML versions of the R manuals
apt-install libgtk2.0-dev        # install.packages("cairoDevice")
apt-install libxml2-dev          # install.packages("XML")
apt-install libssl-dev           # install.packages("openssl")
apt-install libcurl4-openssl-dev # install.packages("curl")

cd $SOFTWARE/GNU/
test -d R-3.4.1 || tar -x -f R-3.4.1.tar.gz
cd R-3.4.1

source $OPT/intel/mkl/bin/mklvars.sh intel64
MKL="-Wl,--no-as-needed -lmkl_gf_lp64 -Wl,--start-group -lmkl_gnu_thread  -lmkl_core  -Wl,--end-group -fopenmp  -ldl -lpthread -lm"

./configure --with-blas="$MKL" --with-lapack --enable-memory-profiling --enable-R-shlib --with-system-tre --prefix=$PROGRAM/R-3.4.1
make       
make info
make pdf
make install
make install-info
make install-pdf 

cd ..
rm -r R-3.4.1

# check for possible update
apt search libbz | grep '\-dev'
apt search libpcre | grep '\-dev'
apt search libcurl | grep 'openssl\-dev'
apt search libcairo | grep '\-dev'
apt search libtiff | grep '\-dev'
apt search libgtk | grep '\-dev'

echo 'press any key to exit'
read nothing
```

- `--enable-lto` will get error
- `--with-blas` will get error (libblas-dev )
- options using defalut value: `--enable-shared`, `--with-tcltk`
- additional options are `--enable-prebuilt-html`, `--disable-rpath`, `--with-included-gettext`, etc
- add `options(bitmapType = 'cairo')` to `~/.Rprofile` after finish



# MKL

no `--enable-BLAS-shlib` while compling R

`.Renviron` fails:

- for R  

  `~/.local/R-3.4.1/bin/R` line 4
  ```
  export LD_LIBRARY_PATH="/path/to/opt/intel/compilers_and_libraries_2017.4.196/linux/tbb/lib/intel64_lin/gcc4.7:/path/to/intel/compilers_and_libraries_2017.4.196/linux/compiler/lib/intel64_lin:/path/to/intel/compilers_and_libraries_2017.4.196/linux/mkl/lib/intel64_lin"
  ```

- for RStudio  

  create `~/.local/bin/RStudio`
  ```bash
  #!/bin/bash
  # shell wrapper for RStudio executable 
  source ${OPT}/intel/mkl/bin/mklvars.sh intel64
  /usr/lib/rstudio/bin/rstudio %F
  ```
