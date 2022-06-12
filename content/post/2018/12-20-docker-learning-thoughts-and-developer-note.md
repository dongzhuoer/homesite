---
title: Docker 学习感悟和开发笔记 | Docker learning thoughts and developer note
date: '2018-12-20'
slug: docker-learning-thoughts-and-developer-note
categories: 2018
tags: []
authors: []
---



# 在 Docker 界摸爬滚打

还记得最开始知道 Docker 时觉得很厉害，要学好了才能用。后来突然[^1]决定开始花时间学 Docker了。于是去图书馆借了一堆书，中文书还是老样子，不是互相抄袭，就是罗列帮助文档。有些还是有点用（后来发现大多来自 Docker 官网），至少看中文更熟悉，先建立点感觉吧。

[^1]: 跟其他 skill 一样，总是想着等到有时间的时候再好好学，然后突然某一刻又会把其它事都放在一边，先把这个学了再说。具体到这次应该是想用 Docker 发布 molecular apomorphy 的程序

不过真正学会还是建立在后面不断练习、探索的基础上，Docker 官方文档就是很好的素材。

我觉得一本好的教程要能让新手建立起感觉，为后面阅读官方文档等学知识做好准备（当然能顺便也教很多知识就更好了）；而且要能吸引人，不要把读者赶走了（这里我是有内在动力、必须学）。中文书最缺少的就是为什么这样，或者说作者不知道新手最难理解的是什么，后来看的 hadley 大神的R书就好多了。



# 第一个image

最早派上用场的 image 是 [apach2](https://bitbucket.org/EdBoraas/apache-docker/src/ab0f232046ff392bb11ec190c25ac1a0688f5ae6/apache/README.md?at=master&fileviewer=file-view-default)，因为当时要建好多本地网站（再次感谢南开校园网）。虽然学会了搭 apache，但做新网站和维护（重命名，改port）特别麻烦，Docker 只用一行命令真是超方便的。



# update or not, that's a problem

后来偶然找到 `watchtower`，自动更新 image （更新狗当然忍不住啊）。之后有些问题没解决 [^unsolved]，而且觉得 Docker 能用就行，手动更新也许更好，就不用了。

[^unsolved]:
    - [ ] whether one watchtower can watch another
    - [ ] what if ubuntu is used by other container who are not watched

---------------

这里记一下当时的笔记：

By default, all containers with  "enable" LABEL are monitored for the local changes of their images.

```bash
docker run -d --name watchtower-local -v /var/run/docker.sock:/var/run/docker.sock v2tec/watchtower --no-pull --label-enable --cleanup
```

If you desire other way for certain container, add a dedicated watchtower container for it,
like the following one (the list of container it monitors might increase in the future)

> Note that it not only update containers, but also update image and remove old ones

```bash
docker run -d --name watchtower-pull -v /var/run/docker.sock:/var/run/docker.sock v2tec/watchtower watchtower-local ubuntu0 centos0 --cleanup
```
