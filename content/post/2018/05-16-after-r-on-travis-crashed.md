---
title: after R on Travis crashed
author: Zhuoer Dong
date: '2018-05-16'
slug: after-r-on-travis-crashed
categories: 2018
tags: []
authors: []
---

In the morning, I routinely checked the updates, including e-mail, GitHub notification, etc. When I browsered Travis CI dashboard, I decided to have a look at [build-adv-r](https://github.com/dongzhuoer/build-adv-r) ^[I use this repo to automatically build Hadley's "Advanced R". I might talk about the reason in the future post about my tiny bookdown website.]. The error message is something like `foobar not exported from rlang`. I searched Google ^[Google is so powerful, I decide to search "GitHub" + some stuff first, before searching something directly on GitHub.] and found that the function is renamed, a normal price for using a development package. To avoid editing the source code, I chose to install an early commit, before the function change its name. Then another problem occurred, and I have completely no idea what's going wrong. It's seems I have to `sed` the `.Rmd`, like [what I did with the another book](https://github.com/hadley/r4ds/issues/612#issuecomment-370239689). While I am trying this, I browsered Hadley himself's build and wonder why his just succeed.

As times went by, I realized I was about to reach the critical point, 9:00 am. According to my experience from many ruined mornings (sometimes even the whole days), that's the point after which I have to start working on my research project. Suddenly, R on Travis crashed, and I knew for sure that the entire mooning is doom to be wasted.

I struggled for a while, only found that there is nothing that I can do to change the suitation. So I turned to the GitHub issue, thinking how to accurately describe the suitation, and found that someone had already fired a [one](https://github.com/travis-ci/travis-ci/issues/9625). It seemed that the power of community is indeed quite strong, I was not alone. Then I spent some time to debug the problem using Dokcer, and luckily enough to find the cause. But I don't know the best solution, so I just wrote a comment. Looking at the container, I don't want to just see it being deleted. Instead, I decided to push it to Docker Hub, under the assumption that it may helps someone else study the problem and explore the solution. 

I planned to build and push the image all on my VPS to save bindwidth, but things didn't happen as I expected ^[I started a container on my VPS and did some stuff, then I plan to exit it and `docer build` on my VPS. Accidently, I pressed Ctrl+D twice, so actually I did the latter on my own laptop. Oh, my bindwidth, 2 RMB / GB!]. Latter, I managed to build the image on my VPS and tried pushing it. But push an image from a remote Ubuntu without desktop is not an easy task, I tried a while and finally gave up and pushed from the local. Anyhow, I was luckily enough to go lunch before 12:30 ^[That is another, even more dangerous point, passing which would skip my lunch and snap and cause very serious consequence]. 

In the afternoon, I eventually managed to continue my thesis, though the first hour still not spent on the core task ^[I tidied my reference, and changed the way to use Mendeley. The first time I got touch with it, I found tag is a better way to group the papers than folder. But now, I switched to folder again.]. As I stepped into the main road, I found making figures really takes time. In the process, I realize although you may be very unwilling to do a task, once you lunch, you just don't want to stop, you ony think about what's the next thing to do.

Before I had to leave the lab. I found there is no time for English, not even enough time to write a post ^[Luckily, I finished 懂你 task after dinner.]. Finally I decided not to bring my laptop to doemitory. Every time I do so, I would stay up past 01:00 ^[I guess the main reason is the hot weather. When I type and wash foot using hot water, the hot air goes up, and I feel very uncomfortable.].
