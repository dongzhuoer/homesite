---
title: UTF 大战和 Google、wikipedia 迷信反思
author: Zhuoer Dong
date: '2017-07-17'
slug: utf-大战和-google-wikipedia-迷信反思
categories: 2017
tags: []
authors: []
---

# 写在前面的话

今天看了好多 Unicode 和 UTF-8 等的知识，稍微整理一下。标题实在不好取，UTF-8 不能概括所有内容，都写上又太长了，就用 UTF 来模糊处理了 ^[受到 Unicode FAQ page 中 [UTF-8, UTF-16, UTF-32 & BOM](http://unicode.org/faq/utf_bom.html) 这个页面的的文件名 `utf_bom` 的启发。]。

首先说一下感悟，要走出对 wikipedia 的迷信。确实它比百度百科好很多，之前用它也得到了很多有用的知识。但是这种多人编辑的页面毕竟没有规范的审阅，就会缺乏统一性和权威性，导致前后矛盾和存在纰漏。

顺便也反思一下，对 Google 也不能太迷信。Google 确实对我学习编程提供了很大的帮助，但也要意识到 Google只是把优秀的页面放到了最前面（而百度360之流则是把广告和垃圾放到了最前面），这些页面中的信息哪些才是正确的还需要程序员自己来判断。

还有编程的世界中最大的 boss 就是 old，obsolete，superseded 之流。Ubuntu系统就是这样，虽然你能享受到最新最全的软件，但是遇到问题时你会发现大部分回答都是在讨论旧版该怎么做（我一般喜欢在搜索时加上版本号，或者直接限制修改日期）。写这一段主要是在好多页面中看到了过时的信息，这些在当时都是正确的，可是到现在就完全错误了，最坑爹的是没有人来打扫这些垃圾，只能靠自己追寻最新的正确信息。



# Unicode

开始讨论正事。以 [FAQ page](#FAQ) 为权威依据，同时参考 wikipedia。

Unicode 其实很简单，就是给每个字符指定唯一的代码。

When Unicode was young, it was a 16-bit encoding. At that time you can encode a Unicode code point with one 16-bit code unit (UTF-16). 但是现在不一样了。   

> The Unicode Standard encodes characters in the range U+0000..U+10FFFF, which amounts to a 21-bit code space.

而且目前官方认定这一范围不会再扩充：

> Both Unicode and ISO 10646 have policies in place that formally limit future code assignment to the integer range that can be expressed with current UTF-16 (0 to 1,114,111). Even if other encoding forms (i.e. other UTFs) can represent larger intergers, these policies mean that all encoding forms will always represent the same set of characters. Over a million possible codes is far more than enough for the goal of Unicode of encoding characters, not glyphs. Unicode is not designed to encode arbitrary data. If you wanted, for example, to give each “instance of a character on paper throughout history” its own code, you might need trillions or quadrillions of such codes; noble as this effort might be, you would not use Unicode for such an encoding. 

Unicode 是用来编码字符的，而不是字形。比如不同人写的“你”都不一样，但是“你”这个汉字却只有一个。给漫漫历史长河中所有纸张上的每一个字赋一个代码当然是可行的，但 Unicode 才不干这破事，要是闲得X疼你可以自己开发一种编码系统。



# UTF-8

UTF-8 绝对没有 BOM，有 BOM 的是 UTF-8 with BOM ^[Windows 就是喜欢做这些无聊的事情, 还有那个该死的 Codepage。到现在我的 R语言中的汉字都是 GB 码，各种出问题，想用 UTF-8 我还得 `enc2utf8()`。]。BOM 是给多字节数据类型使用的，比如 UTF-16。我觉得这也是 UTF-8 的一大优点。

Unicode (hex)   | UTF-8 (bin)
--------------- | ----------
000000 - 00007F | 0xxxxxxx
000080 - 0007FF | 110xxxxx 10xxxxxx
000800 - 00FFFF | 1110xxxx 10xxxxxx 10xxxxxx
010000 - 10FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

开始的128个字符（US-ASCII）只需一字节，接下来的1920个字符需要双字节编码，包括带附加符号的拉丁字母、希腊字母、西里尔字母、科普特语字母、亚美尼亚语字母、希伯来文字母和阿拉伯字母的字符。Basic Multilingual Plane （BMP）中其余的字符（包括中日韩文）使用三个字节，其他 Plane （16 supplementary palnes） 使用四个字节。

UTF-8 的一大好处是 self-synchronizing，也就是说不会像DNA那样发生移码突变。UTF-8 中任何一个字节的损失都只会影响它所在的那个字符。



# UTF-16

UTF-16 也是变长编码，但实现方式与 UTF-8 不同。

1. BMP 的所有字符都可以用一个 UTF-16 code unit 表示。
2. BMP中的 0xD800 - 0xDBFF 保留作 high surrogate，0xDC00 - 0xDFFF 保留作 low surrogate，二者组合成surrogate pairs，编码其他 Plane. （其中 0xDB80 – 0xDBFF 为 High Private Use Surrogates）

值得一提的是编码中日韩文时只需二个字节，比 UTF-8 的三个字节要少；相反，对于英文字符，则是 UTF-16需2字节而 UTF-8只需1字节。

估计就是由于这个原因，Windows 才会把文件名的内部存储方式设置为 UTF-16，然后再通过一大堆垃圾 API 给应用程序不同的编码。弄得我整天提心吊胆，做梦都担心哪天从 Ubuntu 启动后文件名就都变成乱码了，还不能恢复。


