---
title: 气煞人的 .ssh 权限 以及 ssh-add
date: '2017-11-27'
slug: file-permission-ruin-ssh
categories: 2017
tags: []
authors: []
---



GNU 果然不适合新手使用，出个问题简直能把人急死并气死。又浪费我一个多钟头。废话少说，放码过来。



# `.ssh/` 权限

不过你是谁，用的什么系统，一定要保证你的 `.ssh/` 文件权限是这样子的:

```
total 20
drwx------  2 user user 4096 Nov 27 22:35 .
drwxr-xr-x 38 user user 4096 Nov 27 22:22 ..
-rw-------  1 user user 3243 Nov 27 22:14 id_rsa
-rw-r--r--  1 user user  738 Nov 27 22:14 id_rsa.pub
-rw-r--r--  1 user user  222 Nov 27 22:14 known_hosts
```

不然，你余生中每次ssh都得输入密码，用 `ssh-copy-id` 也没用。

举一个我自己遇到的血淋淋的例子。之前某一电脑有两个用户，为了方便访问，我便作死地 `chmod 777 -R /home/user2`，然后每次 `ssh` 到 `user2` 都得输密码。直到后来才想起来可能是改权限造成的，于是我将 `.ssh/` 及其包含的每一个文件都改回默认权限（从可以正常使用的 `.ssh/` 中抄过来），但还是不行，简直都要崩溃了。后来在绝望中把 `..` （`/home/user2`）也改了，然后……就豁然开朗了。

还有一个副作用就是 `ssh-copy-id` 会很智能地避免重复，但是权限有问题时就不灵了，所以你会看到服务器上有十几条你的公钥，你却还是得输密码，就问你香不香菇。



# 傲娇的 `ssh-add`

千万不要用 `ssh-add`，除了 `ssh-add -l -E md5` [^1]。但是你得非常小心，万一漏了 `-l`,就得赶紧 `ssh-add -D` （偷偷告诉你 Bash 有个功能叫 **alias**)。

因为这玩意加的公钥的注释是文件名 (`/home/user/.ssh/id_rsa`)，而不是 `user@host`。这无疑会给 `ssh-copy-id` 造成很大的麻烦，因为在服务器上你都分不清哪个公钥是谁的。

[^1]: 顺便发现了一条用于比较 GitHub fingerprint 的命令，比 `ssh-keygen -l -E md5` 略微方便一点，省去指定文件名的麻烦。



# gnome-keyring 也来参合

顺便加一句，安装 **gnome-keyring** 之后，`ssh-add -l` 就会有一项保留项 `user@host`。

最坑爹的是，我当时不小心用了 `ssh-add`， 于是两个公钥（虽然值都是一样的）都在，然后 `ssh-copy-id` 那一个酸爽啊。每次都是加两个，简直形影不离。
