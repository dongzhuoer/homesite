---
title: install Utopia Documents, dependency is indeed troublesome
date: '2019-04-07'
slug: install-utopia-documents
categories: 2019
tags: []
authors: []
---



In the last section of _Bioinformatics Challenges, at the Interface of Biology and Computer Science, Mind The Gap_, the author recommands Utopia Documents, so I decide to install it (otherwise it should be quite hard to follow the book).

According the official guide, I add neurodebian's repository to `apt`, but `utopia-documents` can't be found.

Windows installer is fairly easy, so I consider to swicth to Windows to experience this software.

Then I search Google, from an answer for early version of Ubuntu, I try to install `neurodebian`. During the installation, a pop up asks me whether to add extra repository, and I choose "yes". Thus the method seems same as above, and unsurprisingly failes. 

Later, I search for `.deb` and find one. Looking at the long dependency list, I foresee the installation would fail. And it indeed, `libpoppler68` is missing [^1], I find a `.deb`; then `python-imaging` is missing, and I find another `.deb`. It won't suprise me if a third package is missing, conversely, the installation succeed this time. 

I can't wait and try the software. Several minutes later, I get amazed by its functionality. All the effort pays. 

[^1]: Quite puzzling, it comes from [poppler 0.57.0-2ubuntu4 source package in Ubuntu](https://launchpad.net/ubuntu/+source/poppler/0.57.0-2ubuntu4), actually I try many times before figure out the right version, `0.57.0`.
