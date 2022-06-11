---
title: 续 final piece，Jupyter 终于支持 script 的 run selected 了
author: Zhuoer Dong
date: '2020-09-21'
slug: 续-final-piece-jupyter-终于支持-script-的-run-selected-了
categories: 2020
tags: []
authors: []
---



> 2020-11-26 前言：又双叒叕把积压的 post 清空了，希望 `draft.md` 再也不需要存在了。

虽然“final piece”实现了 Notebook 的 run selected，`.py` Editor 还是不行，之前是把代码复制 Notebook，改好后粘贴回来。局部修改凑合着还可以用，大幅修改就很烦人了，今天一定要好好鼓捣一番。

[这个 issue](https://github.com/jupyterlab/jupyterlab/issues/450#issuecomment-263817275) 很好，但你别光 show GIF 啊，写清楚怎么设置啊（回头想，默认就行，我是 disable 了所以用不了）。

想找 `Run Selected Code` 按钮到底对应哪个 command，甚至 clone Jupyterlab 的 code 来分析

```json
{
    "command": "runmenu:run",
    "keys": [
        "Shift Enter"
    ],
    "selector": "[data-jp-code-runner]",
},
```

就很好，但是把 Notebook 的 Shift Enter 覆盖了。

探索一番：

1. `"disabled": true,` 只是 disable 快捷键，而不是整个 command。
2. 新的 shortcut 是添加，而不是覆盖。

最后祭出浏览器调试大法，发现 `.jp-FileEditor` 可以将 `.py` Editor 与 Notebook 区分开来。

```json
{
    "shortcuts": [
         {
            "command": "notebook:run-cell-and-select-next",
            "keys": [
                "Shift Enter"
            ],
            "selector": ".jp-Notebook.jp-mod-editMode",
            "disabled": true,
        },
        {
            "command": "runmenu:run",
            "keys": [
                "Shift Enter"
            ],
            "selector": "[data-jp-code-runner]",
            "disabled": true,
        },
        {
            "command": "notebook:run-in-console",
            "keys": [
                "Shift Enter"
            ],
            "selector": "body",
        },
        {
            "command": "runmenu:run",
            "keys": [
                "Shift Enter"
            ],
            "selector": ".jp-FileEditor",
        }
    ]
}
```
