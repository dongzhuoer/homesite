---
title: final piece of Jupyter--run selected in console--for production usage
date: '2020-07-24'
slug: final-piece-of-jupyter-run-selected-in-console-for-production-usage
categories: 2020
tags: []
authors: []
---



以前谢益辉就说过，Jupyter 相对于 R markdown 的一大缺点是不能运行 selected code。也正是因为这一点，我使用 Jupyter 时总是非常不顺手，因为想运行代码就必须 +Cell。后来搬砖时，还鼓捣出了写代码、上传、得结果、下载、可视化的工作流程。

最近觉得这样太麻烦了，还不如直接在服务器的 Jupyter 运行，于是又回到 selected code 的问题。抱着试试看的心态放狗一搜，JupyterLab 还真支持！赶紧配置一番快捷键，终于可以随心所欲地 run selected（而不是 whole cell）了。

（就不再罗嗦后面附的是什么了，反正聪明的读者一看就明白了。）

```json
{
    "shortcuts": [
         {
            "command": "notebook:run-cell-and-select-next",
            "keys": [
                "Shift Enter"
            ],
            "selector": ".jp-Notebook.jp-mod-editMode",
            "disabled": true
        },
        {
            "command": "runmenu:run",
            "keys": [
                "Shift Enter"
            ],
            "selector": "[data-jp-code-runner]",
            "disabled": true
        },
        {
            "command": "notebook:run-in-console",
            "keys": [
                "Shift Enter"
            ],
            "selector": "body"
        },
    ]
}
```
