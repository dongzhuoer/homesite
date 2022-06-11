---
title: Where there is an error, there is a log
author: Zhuoer Dong
date: '2017-12-09'
slug: journalctl-solves-privoxy
categories: 2017
tags: []
authors: []
---


We all know one should test thing before use in the world of programming, but sometimes that is not enough. 

When you use **systemd**, you often encounter the situation where a command runs well in Bash, but fails when you make it a service. I have meet this situation many times on Ubuntu, and moves to CentOS unsurprisingly increases the probility of error.

What I learned today is that, log message always tells you _more_ than what you think. Atfer struggling for a while to understand the concise meassge `systemctl status` says, I found there is a lot of information in `journalctl`.

--------------------

Finally, welcome our lead actor, `privoxy`. 

I want to open the a to LAN, `firewall` is already configured:

```bash
sudo firewall-cmd --permanent --zone=public --add-port=****/tcp
sudo firewall-cmd --reloads
```

But I need also set SELinux

```bash
semanage port -a -t http_cache_port_t -p tcp ****
```


