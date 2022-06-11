---
title: Goodbye, local cppreference.com
author: Zhuoer Dong
date: '2018-11-30'
slug: goodbye-local-cppreference-com
categories: 2018
tags: []
authors: []
---

# Beginning

Back to the days I was in Xie Lab, developing apocode. <https://cppreference.com> is really an awesome reference.


# develop

Thanks to NKU LAN, I build a local version of that website.


# Climax

Then Tsinghua network is a lot better. Moreever, Today I find the website's CSS seems broken. So I delete the website, and move to building code here.


# Appendix

download raw offline version at http://localhost:1034/w/Cppreference:Archives, and see what is missing in `wget` command

``` bash
vps nohup wget -mp http://en.cppreference.com/w/cpp -I /mwiki/extensions,/mwiki/skins,/w/c,/w/cpp &> /dev/null &
vps tar -cz -f en.cppreference.com.tar.gz en.cppreference.com
scp root@$ipv4:~/en.cppreference.com.tar.gz .

# extract

curl http://en.cppreference.com/w/Main_Page > en.cppreference.com/w/Main_Page.html
R -e "c('DejaVuSans-Bold.ttf', 'DejaVuSansMono-Bold.ttf', 'DejaVuSansMonoCondensed60.ttf', 'DejaVuSansMonoCondensed75.ttf', 'DejaVuSansMono.ttf', 'DejaVuSans.ttf', 'favicon.ico', 'robots.txt') %>% paste0('curl http://en.cppreference.com/', ., ' > en.cppreference.com/', .) %>% parallel::mclapply(mc.cores = 16, system)"
R -e "dir('en.cppreference.com', full.names=T, recursive=T) %>% dirname %>% {c(., dirname(.))} %>% unique %>% paste0('[ -f ', ., '/index.html ] || curl http://', ., ' > ', ., '/index.html') %>% parallel::mclapply(mc.cores = 16, system)"
```

```r
dirs <- dir('en.cppreference.com', full.names=T, recursive=T)  %>% unique
```

```bash
curl http://en.cppreference.com > en.cppreference.com/index.html
curl http://en.cppreference.com/w > en.cppreference.com/w/index.html
curl http://en.cppreference.com/w/c > en.cppreference.com/w/c.html
curl http://en.cppreference.com/w/cpp > en.cppreference.com/w/cpp.html
curl http://en.cppreference.com/w/Main_Page > en.cppreference.com/w/Main_Page.html
```




