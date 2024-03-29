---
title: understanding .bashrc, 七窍终于通了六窍
date: '2018-01-07'
slug: bashrc
categories: 2018
tags: []
authors: []
---



> 2019-11-24 feel too complicated, I just need to make link in `~/.local/bin` (`~/.profile` already add it to `PATH`). 

relogin 是真××烦，本身浪费时间不说，打开的应用全部都得关闭，尤其是我打开了倒计时的时候真想砸键盘，有什么资格笑话 Windows

The most common case where I need custom settting is Bash Terminal

If you really need a unified interface in every place: R `system()`, Python subprocess, MATE top bar add application, ...

- `~/.bashrc` beginning

```bash
source ~/.local/bash/shell/profilerc.sh;

# user defined alias
source ~/.local/bash/shell/alias.sh

# auxiliary function
source ~/.local/bash/shell/function.sh
```

- `~/.profile` end

```bash
source ~/.local/bash/shell/profilerc.sh
```

模仿 C++ micro to avoid source twice

# Preface

For everyone using Linux (maybe someone using Windows as well), though he may not feel for environment variables, he is possibly very familiar with `PATH`, and usually struggle with it for a hard time.

Indeed, `PATH` is very important, but its meaning is very sophisticated. This contributes a lot to the steep learining curve of Linux, since you have to understand a very obscure concept at the very beginning. (If you don't settle `PATH` properly, you would meet endless trouble.) 

It is very common to spend a long time in thoroughly understanding `PATH`. I spent about a year (since I first used it) or more than a year and a half (since I first contacted it).

Let's cut the cackle. On Ubuntu, there are two files, three classificaions. So the situation is far more complicated than [bash的四种模式](http://feihu.me/blog/2014/env-problem-when-ssh-executing-command-on-remote/#bash%E7%9A%84%E5%9B%9B%E7%A7%8D%E6%A8%A1%E5%BC%8F), and I simplify it to two most command cases.



# two files

`~/.profile`
```bash
code block A

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

code block B
```

`~/.bashrc`
```bash
code block C

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

code block D
```



# three classificaion



## login and nologin shell

- login shell uses `~/.profile`

  ssh, tty, desktop itself (including application from MATE panel, such as RStudio's rsession)

- nologin shell uses `~/.bashrc`

  ssh command, terminal (emulator)
    
## Bash or not

If `~/.profile` is sourced (other shell includes `/bin/sh`, etc, such as desktop),

- Bash shell: A, `~/.bashrc`, B
- other shell: A, B 

## interactive or non-interative

If `~/.bashrc` is sourced,

- interactive shell: C, D
- non-interactive shell: C



# two most command cases

The two most common cases are (1) terminal from desktop and (2) login via ssh or tty. It seems that they both include all the `PATH` specification in both files, but the underlying mechanisms are quite different.

- terminal from desktop

  First, the desktop is a login, non-Bash shell; then terminal is a non-login, interactive shell, the result is A, B, C, D

- login via ssh or tty

  Instead, ssh or tty is a login, interactive, Bash shell, the result is A, C, D, B.



# 一窍不通

What I can't imagine is the result of ssh command on remote machine and local machine is different. In theory, it should be C. But on local machine, the result is actually, A, B, C. It seems the path in desktop (via `~/.profile`) is mixed into the ssh command in a unknown way[^bug].

[^bug]: 209-03-25: 现在没精力考证，也许是要用 `''` 把 command 括起来。


# finally solution

> Don't use this method if you don't understand what I talked above, or you would easily run into trouble and don't know how to solve it.

I make a file (致敬 Macro in C/C++ header file)

```bash
#!/bin/bash
# set the environment variable path

# only run following block once
if [ -z "$path" ]; then
    export path=yes
    
    # PATH specification here
    export PATH="$HOME/.local/bin:$HOME/.local/exec:$PATH" 
fi
```

and source it in both  B part of `~/.profile` and C part of `~/.bashrc`. 



# Afterword

I'm still not successful with alias, https://stackoverflow.com/questions/30305973 may help.

Maybe I now know, unlike environment virables, function can't be nested sourced. But I don't want to maintain two file lists for now.
