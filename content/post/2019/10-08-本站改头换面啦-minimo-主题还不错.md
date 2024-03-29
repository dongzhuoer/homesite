---
title: 本站改头换面啦，Minimo 主题还不错
date: '2019-10-08'
slug: 本站改头换面啦-minimo-主题还不错
categories: 2019
tags: []
authors: []
---



当时 [Tranquilpeak](https://github.com/kakawait/hugo-tranquilpeak-theme/blob/master/docs/user.md) theme 最吸引我的是 category 页面，但随着 nutshell 和 memoir 的独立，也该换个好看的 theme了。

这时最能体会到 blogdown 的优点，markdown 才是核心，网站只是一种展现形式。我可以随心所欲地换 theme，或者稍微修改一下就能变成 bookdown。



# Old [^old-C] tranquilpeak

[^old-C]: 这个梗是当年 C++ 还没有名字的时候，大家使用了各种各样的称呼, new C, better C，相应的 C 语言就成了 old C, bad C。为此 C 语言的创始人还专门找 C++ 创始人聊过。

- only files under `content/post/` directory is categoried (you may search `where .Data.Pages "Type" "post"`)
- multiple categories will be treated as hierarchy
- tag and category must be vector [^category-vector] (maybe a bug)



# new [Minimo](https://github.com/MunifTanjim/minimo)

挑了半天，还是简单的最好，因为我的博客主要是文章，核心需求是方便地组织和管理文章（如 tag, category），不需要那么多炫酷的展示方式。权和利弊之后，Minimo 脱颖而出。

拿到手之后肯定是先修改一番，主要是主页去掉与侧边栏重复的部分，[文档](https://minimo.netlify.com/)中主页加上的一段话我也很想要，但是翻了半天也不知道怎么弄，只能暂且按下。

后来发现 `baseURL/post` 页面是空的，比较一会才发现是 `_index.md` 的锅。比如把 `content/post/zhuoer/` 的 `_index.md` 删掉之后， 该目录下的几篇 post 就会出现了。我还以为 `baseURL/post` 是一个特殊的页面呢，这样看来只是对应 `content/post` 文件夹而已。突然想起来 `_index.md` 还是当时为了方便 cross-reference [^cross-reference] 特意创建的，现在却忘得一干二净，所以才想要写下这段话记录一下。



# future X

下面是挑选 theme 时感觉还不错的，供以后改版参考。

带左侧边栏的

- https://themes.gohugo.io/theme/engimo/
- https://themes.gohugo.io/theme/hyde-hyde/ （报错不能用）

只有水平导航栏和文章列表

- https://github.com/yihui/hugo-lithium
- https://themes.gohugo.io/theme/cayman-hugo-theme/  （needs Hugo extended）



[^category-vector]:
    error

    ```yaml
    tags: foobar
    ```

    right

    ```yaml
    tags: 
      - foobar
    ```

[^cross-reference]:

    [_nutshell_](https://bookdown.dongzhuoer.com/zhuoer/nutshell/) 有写让 Hugo 根据 slug 自动生成链接的方法，但是语法太丑了。
    而 `_index.md` 结合

    ```toml
    [permalinks]
    # sections is the most inner directory which contains `_index.md`
    post = "/:sections/:slug/"
    ```

    可以使 post 的链接固定为 `baseURL/sub_folder/slug.html`，这样在其它 post 中就可以用简单的 `[]()` 来引用。
