---
title: don't be lazy--RStudio Server's Upload button let me feel the
  desperation of genewise failure again
date: '2017-12-07'
slug: not-rely-on-rstudio-server-upload
categories: 2017
tags: []
authors: []
---



# Perface

As for genewise, I don't want to regret how much time I have wasted on it, neither do I need to complain how desperate and despaired I felt with it [^typo]. I just want to make two points:

[^typo]: let alone the url in HaMStR `README.txt` should be <http://www.ebi.ac.uk/~birney/wise2/> rather than <http://www.ebi.ac.uk/~Ebirney/wise2/>.

1. biostars is really a good place, especially for tips on bioinformatics softwares. It was from [there](https://www.biostars.org/p/87823/) I found a practicable solution.

1. Debian source package is always prefered to posts (from 百度经验 to StackOverflow).


# Beginning

Back to the days I stay in Xie Lab, my research project heavily relies on HaMStR, which depends on genewise.

I tried numerous times, but still can't build it from source. Luckily, `apt` provides a `wise` package. However, that means I won't be able to use it on the CentOS workstation.


# Development

Thanks to Debian source package so much. I finally find a way to build genewise from source, though it's not quiet straightforward.

You need to download the Debian source package from [here](https://packages.debian.org/en/sid/wise), the uncompass the downloaded two tarballs:

```bash
$ls
debian wise-2.4.1
```

Unfortunatelly, there is some inconsistency is the patch file. So you have to replace

```
--- a/
+++ b/
```

with

```
--- wise-2.4.1.orig/
+++ wise-2.4.1/
```

in `10_fix_path_to_data_files.patch` and `11_consistent_manual_dates.patch` (The above line is optional, but replacing both make it looks tidy.)

> In the new version, there seem to be one more file: `spelling.patch`. Anyway, **VSCode** is a good choice, but remember to `Save all` after you finish the replacing. 

Then, you can patch, build and enjoy:

```bash
for file in debian/patches/[01]*.patch; do patch -p0 < $file; done

cd wise-2.4.1/src
make all
```


# Climax

I feel so happy and encouraged that I can't wait to port it to the CentOS workstation.

But the good scene doesn't last long. When I `make` on CentOS, I was told that `dyc` can't be found. Oh, that error again, I return bakck to refer `INSTALL` of genewise, tried to make `dyc` with a tiny hope, watched it failed without any surprise. 

To flog a dead horse, I uploaded the `dyc` file I made on Ubuntu by the **Upload** button in RStudio Server. It complains about the permission so I `chmod +x`. Then it moved on till the final step, `welcome.csh`. I met the permission problem and do `chmod +x`  again. 

Though I get the binary executables, I wasn't assured. So I tried the test program. Again, it failed. The is something wrong with the `wisecfg/` location. Even if I set env variable `WISECONFIGDIR`, genewise still tried to search in `/usr/share/wise`. (It's resonable since it's a Debian package, and there is actually a `wise-data` package. But it bothers me.) I don't want to copy `wisecfg` directory to `/usr/share/wise` since I want to put genewise into `~/.local`. Thus I turned to edit the source code, i.e., replace all `/usr/share/wise` with `/home/user/.local/lib/wisecfg`. This time everything is okay.



# Epilogue

Succeed as I do, I still can't feel relieved to rely on a binary executable made on Ubuntu to work on CentOS.

> 真香！After `make muscle` failed on CentOS and Google it for about 30 minutes provides no solution, I copy the executable from Ubuntu.

So, I start to think why this happens. The twice permission problems give me some clues. Then it dawned on me that the `Upload` button may break some files' permission so that some command can't be executed. Anyhow, I think genewise should told me excatly where the error lie, like I wrote above, rather than `dyc not found`. 

Thus I make a `.tar.gz` and upload, uncompass. Finally I can _build_ genewise on CentOS! (Of course I remembered to `chmod -x ~/.local/bin/dyc` to make sure I have solved the problem.)

By the way, I found even `scp` didn't work the only solution is `.tar.gz`. Actually I wasn't a bit annoyed, instead I felt quiet at ease since the default compress way preserve many important feature thus save me many troubles.
