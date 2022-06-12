---
title: 'yet another will: cross-link between pkgdown websites'
date: '2018-12-24'
slug: cross-link-pkgdown-websites
categories: 2018
tags: []
authors: []
---



> sometimes you just need to wait, wait, and wait, then the function you desires would suddenly coming into being.


# Preface

自从我在本科毕设写了 [4个包](https://dongzhuoer.github.io/thesis/), 我就一直梦想着不同包之间的  pkgdown website 能够 cross-link，还专门写了个 [issue](https://github.com/r-lib/pkgdown/issues/765)。具体来说，我希望 A 包的网站提到 B 包的函数时，能够链接到 B 包网站的对应页面，而不是 [R Documentation](https://www.rdocumentation.org/) 。


# Beginning

今天的主题本是 tidy eval，还记得第一次看 [**dplyr** vignette](https://dplyr.tidyverse.org/articles/programming.html) 时的从入门到放弃，虽然 **hgnc** 用到了 `sym()`, `!!` 等，但一直没彻底弄懂。至今，在使用 **dplyr** 时总是不放心，各种担心潜在的冲突。说来可笑，本来 dplyr 就是为直接用变量名而设计， 比如 `mtcars %>% select(wt)`。但我总是想要写成 `mtcars %>% select('wt')` （这样基本不用担心以后不小心创建了名为 `wt` 的全局变量）。从昨晚回宿舍后到现在，我终于看懂啦！(我的作业呀, 今晚 23:59 截止啊!)


# Development

但是我偶然间发现, vignette 的 ["Different expressions"](https://dplyr.tidyverse.org/articles/programming.html#different-expressions) 的上面一句话，`rlang::.data` 的链接居然不是 https://www.rdocumentation.org/，而是 https://rlang.r-lib.org/ ！看来有人和我想得一样啊。

然后我就开始继续琢磨 cross-link 的具体实现，issue 中提出的是由 A 包指定 B 包、C 包等的文档分别在哪，有没有更好的方式呢？突然间，我想到可以由 B 包指定自己的文档在哪（也许在 `DESCRIPTION` 中新建一个 field），然后其他包就都知道 B 包的函数应该 link 到哪，这样就能省去好多重复。

之后我一边探究 dplyr 是怎么做到的，一边想着这一想法加到 issue 中。通过研chao究xi **dplyr** 源代码，我做到了把我自己的包（如 **rGEO**） cross-link 到 **rlang**，但就是做不到我自己的包（如 **rGEO** 和 **hgnc**）相互之间 cross-link。



# Climax

最后我开发了一招绝招，向 source code [^1] 中插入 `cat()` 然后 build，终于破解了幕后的黑魔法：

[^1]: 把包放在 GitHub 就是好啊，随时都可以扒开源代码。我以前只是看一下函数是怎么实现的（此处必须感谢 VSCode 的搜索功能），今天实在看不懂了，不得已出此下策。效果还真不错，比调试好多了（我就不吐槽 R 的 debug 是多么地复杂和无用了）。

假设 **rGEO** 的文档提到了 **rlang** 的函数，**pkgdown** 就会首先访问 **rlang** 在本地的 `DESCRIPTION`，找到 `URL`

```
URL: http://rlang.tidyverse.org, https://github.com/r-lib/rlang
```

然后逐个尝试下载 `pkgdown.yml`，发现 `https://rlang.r-lib.org/pkgdown.yml` 是存在的：

```yaml
pandoc: '2.2'
pkgdown: 1.3.0.9000
pkgdown_sha: fa9b7502e80401db4b410086b0a8f6ab444f0c66
articles: []
urls:
  reference: https://rlang.r-lib.org/reference
  article: https://rlang.r-lib.org/articles
```

利用 `urls` 包含的信息，`rlang::eval_tidy` 的链接就应该是 https://rlang.r-lib.org/reference/eval_tidy.html (这里看起来只是简单地把 `reference` 的 url 和函数名串在一起，但实际上 `.html` 的文件名取决于函数所在的 `.Rd` 的文件名）。



# Epilogue

看来 **pkgdown** 已经实现了我想要的 cross-link，而且方式和我想的几乎是一模一样。果然好的规范总是很相像，坏习惯则各有各的坏法。



# Afterword

我还是负责地把我的发现写成了 [issue](https://github.com/r-lib/pkgdown/issues/946), 让更多人受益。（再次心疼我的作业，晚上要废了。）
