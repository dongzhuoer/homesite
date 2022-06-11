---
title: deploy Shiny App on shinyapp.io
author: Zhuoer Dong
date: '2017-11-29'
slug: deploy-to-shinyapp-io
categories: 2017
tags: []
authors: []
---

Google 又抽筋了，得换个 VPS。这样的话，把 pgmcs Shiny app 放在 VPS 就太麻烦了，于是移到了 205 台式机。但这样只能在校园网访问，于是我就开始寻找托管服务，一番比较之后定为 http://www.shinyapps.io/ （其实也没得选）。

配置挺人性化的，不过免费用户限制为 5 Applications、25 Active Hours，于是我就开始杞人忧天，然后大半个下午就这么浪费了。

刚开始我用设置来限制用户使用时间，后来又觉得算了，就用默认值吧。于是我从 shinyapps.io 删除原来的 app，重新上传一个新的 app，但试了好几遍都无法恢复默认值。

我觉得是缓存的问题，就各种设法清除缓存。最后终于从函数的源代码找到了缓存的位置，原来在 `AppDir` 目录下藏了一个 `rsconnect` 的文件夹。^[不过这也说明了我用 `system.file()` 的合理性，直接用开发目录的文件的话就公开到 GitHub 上了，像我之前那个可伶的 GitHub token 一样。]

--------------------------

shinyapps.io 使用方法

1. https://www.shinyapps.io/admin/#/tokens `Show`
2. `remotes::install_github('dongzhuoer/pgmcs')`  
   This is very important for **rsconnet** to properly handle package dependency.

shinyapps.io 文档  

- https://shiny.rstudio.com/articles/shinyapps.html
- http://docs.rstudio.com/shinyapps.io/applications.html#active-hours