---
title: Git bug 四则，SSL, help, force push, file size
date: '2019-03-24'
slug: git-4-bug
categories: 2019
tags: []
authors: []
---



以前折磨 Git 时遇到的四件事



# SSL certificate

当时在 Windows 突然不能 clone repo 了

`git config --system http.sslcainfo C:\path\to\Git\mingw64\ssl\certs\ca-bundle.crt`



# open help in Chrome

当时想打开 HTML 版的 help （而不是在终端不停按 `D`）,就在 `.gitconfig` 加了

```
[help]
    format = web
[web]
    browser = google-chrome
```

结果

``` bash
$ git help help
$ [6498:6534:0921/151937.678061:ERROR:browser_gpu_channel_host_factory.cc(103)] Failed to launch GPU process.
Created new window in existing browser session.
```

后来发现 `-w` 选项是更好的方式，如 `git help push -w`



# force push to an existing GitHub repo

后来新建 GitHub 都会记得建一个 _empty_ repo，但那时还会不小心选上 `Initialize this repository with a README`，就有了下面的代码

```bash
git commit --allow-empty
git branch --set-upstream-to=origin/master master
git pull --allow-unrelated-histories
```


# remove big file

Git 会很忠实地保存每一项更改，如果你不小心 `git add` 一个大文件（如 100 MB）， 那么压缩后的空间（如 40 MB）就会一直保留在 `.git/` ，即使把大文件删掉也没用。能及时发现还好，只要记得文件名，还是可以从 history 中移除的；反之，过了一段时间的话，就很难处理了。

所以我当时很担心 `.git/` 的大小，总觉得 history 里面藏着好多添加、又被删除的大文件。然后就到腾出了如下脚本，大概是列出每一个 commit 的所有文件的大小。

```bash
git ls-tree -rl master 
# numfmt https://unix.stackexchange.com/questions/44040/a-standard-tool-to-convert-a-byte-count-into-human-kib-mib-etc-like-du-ls1
git ls-tree -rl 0ea4fa7 | sort -k 4 -n | numfmt --to=iec --field=4

du-commit () {
   git ls-tree -rl "$1" | sort -k 4 -n | numfmt --to=iec --field=4 
}

export -f du-commit

git tree | grep -Po '\w+\d+\w+' | xargs -n1 -I '{}' bash -c 'du-commit {}'
```
