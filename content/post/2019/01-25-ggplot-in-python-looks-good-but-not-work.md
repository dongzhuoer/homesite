---
title: ggplot in Python, looks good, unfortunately doesn't work
date: '2019-01-25'
slug: ggplot-in-python-looks-good-but-not-work
categories: 2019
tags: []
authors: []
---



# Beginning

今天翻了 hadley 大人的主页，发现了个好东西：https://github.com/hadley/ggplot

正好要开始好好学 Python，赶紧试一下

# pip3

problem

```
type object 'numpy.ndarray' has no attribute '__array_function__'
```

solution

```
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy==1.15.4
```


# pip2

problem

```
ImportError: No module named _tkinter, please install the python-tk package
```

solution

```
sudo apt -y install python-tk
```

# both failed

Then both result in 

```
You can access Timestamp as pandas.Timestamp
  pd.tslib.Timestamp,
...
ImportError: cannot import name Timestamp
```

# Afterword

R 可能真的快被我翻得差不多了，也该去 Python 里找有意思的东西了
