---
title: 用 apache 搭建本地网站
author: Zhuoer Dong
date: '2017-11-07'
slug: apache-local-website
categories: 2017
tags: []
authors: []
---



# Preface

搭建本地 server 是 GNU 进阶用户的必备技能，当你支持本地 HTML 文件使用 `/` 之后，很多事就方便许多了。比如 Gitbook 的搜索功能 ^[后来我发现还是 Google site search 好用，支持模糊搜索，不然你就非得把完整的单词、甚至多个单词及其相对顺序背下来]，克隆大牛的网站 ^[参见我昨天发布的 [**rget**](https://github.com/dongzhuoer/rget)]。

下面是我记的笔记，详细描述请参考 Digital Ocean 的 [这篇文章](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-16-04)。



# Quick example

1. install software

   ```bash
   sudo apt -y install apache2
   ```

1. `.conf` file 

   ```bash
   sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/test.conf 
   ```

   part of `/etc/apache2/sites-available/test.conf`
   ```apache
   <VirtualHost *:81>
       DocumentRoot /path/to/test
       
       <Directory /path/to/test>
           Require local granted
       </Directory>
   </VirtualHost>
   ```

   `local` means denying access from LAN ^[之前用的是 `Require all granted`，有一天突然发现手机可以访问电脑上的本地网站，当时真是既兴奋又担心啊。后来才发现只有同在校园网才能访问，直接从公网是不行的，然而为了安全还是改成仅限本地电脑了。], refer to https://stackoverflow.com/questions/6264372/


1. listen port

   add `Listen 81` in `/etc/apache2/ports.conf`

1. enable website

   ```bash
   sudo a2ensite test.conf
   sudo a2dissite 000-default.conf
   sudo systemctl restart apache2
   ```

Now you can access your website at http://localhost:81.



# Alias

You can **mount** arbitary directory into your apache server using `Alias`:

```apache
<VirtualHost *:1024>
    DocumentRoot /path1/to/mysite

    Alias "/examples"    "/path2/to/myproject/demos"
</VirtualHost>
```

Then `localhost:1024/examples` would retrieve the file `/path2/to/myproject/demos/index.html`.


# Solve 403 permission issue


In `/etc/apache2/apache2.conf`
```apache
<Directory />
    Options FollowSymLinks
    AllowOverride None
    Require all denied
</Directory>

<Directory /usr/share>
    AllowOverride None
    Require all granted
</Directory>

<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
```

If you website directory (such as `/path/to/test`) isn't contained in `/var/www/` or `/usr/share`, the first block would take effect. That means `Require all denied` will cause an annoying 403 error.

The solution is to manually set:

```apache
<Directory /path/to/test>
    Require all granted
</Directory>
```



# Afterword

Except for `a2ensite`, you can also use `sudo vim /etc/apache2/sites-enabled/` to view and manage enabled `*.conf` files ^[现在想起来，好像是我无意间发掘了 vim 的编辑 _文件夹_ 功能，当时还以为是 apache 的一个特殊文件。].

2018-04-29: When applying to docker, it wasted me another a hour or two. I finally realized that from container's view, `localhost:1025` on my Chrome is actually **remote**. Thanks SO again, `Listen 172.0.0.1:80` is really a ingenious idea. Inspired by it, I came up with `-p 127.0.0.1:1025:80`. The best thing is that I no longer have to toggle the daunting apache configuration.
