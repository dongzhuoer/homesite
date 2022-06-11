---
title: temporarily live in New York when install Ubuntu
author: Zhuoer Dong
date: '2018-07-02'
slug: temporarily-live-in-new-york-when-install-ubuntu
categories: 2018
tags: []
authors: []
---

When installing Ubuntu, timezone and locale is something you need to take care of. Like language, English is _always_ better than Chinese in the programming world.

In short, you have two choices: 

  1. choose China and set locale later   
  2. choose US and set timezone later

Finally I adopt the latter because it's so hard to find the _best_ code for setting locale _completely_. 

---------------------

Anyway, I will still list the current command:

`sudo update-locale LANG="en_US.UTF-8" LC_NUMERIC="en_US.UTF-8" LC_TIME="en_US.UTF-8" LC_MONETARY="en_US.UTF-8" LC_PAPER="en_US.UTF-8" LC_NAME="en_US.UTF-8" LC_ADDRESS="en_US.UTF-8" LC_TELEPHONE="en_US.UTF-8" LC_MEASUREMENT="en_US.UTF-8" LC_IDENTIFICATION="en_US.UTF-8"`