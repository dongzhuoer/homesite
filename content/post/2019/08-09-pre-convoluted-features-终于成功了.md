---
title: pre-convoluted features 终于成功了
date: '2019-08-09'
slug: pre-convoluted-features-终于成功了
categories: 2019
tags: []
authors: []
---



> 一晃都有三个多月没有写日记了，看来维护 Zhuoer's Empire 还是很困难啊。毕竟都忙着眼前的事，由此可见可重复研究的阻碍很大啊。

> 两个月后又把这篇 post 整理了一下，具体的 bug 已经很难重现了，唯一记得的就是当时真是浪费了我成吨的时间。

_Deep Learning with PyTorch_ chapter5 教我 preconvlute VGG（only train fc layer），明明 freeze 卷积层参数可以有很好的准确度，但只要我先把 feature 算出来保存到 `.npz`，就一直上不了 70%。

本来放过去了，到 chapter8 又遇到这个问题。不用说，用 resnet 一样不行。搞得我过了好久都没把这本书看完。我甚至专门 train 出一个 95% 的模型，然后载入这个模型的参数之后再 pre convolute，还是不行。

今天终于终于找到原因了，一句话来说就是没有用 `model.eval()`。因为训练好的 model 是在 `eval()` 时最优，也就是 feature 提取得好，fc 分类也很好；而默认的 `train()` 会有 dropout，这时 feature 就不是最佳的了，只调整 fc 当然不会有很好的结果。

回想起来，我在 debug 的时候经常会 `test(model, valid_loader)`，这就使得模型进入了 eval 模式（而初始是 train 模式）。由于我的时间是片段化的，经常遇到刚才两个结果还是一样的，然后突然就不一样的情况，这还怎么 debug 嘛！

然而，当我熬夜想找到具体原因时，`model.eval()` 又不那么重要了。可能是白天探索时，有的模型是 `train()`，有的是 `eval()` 吧；也可能是我有时用 `model.training = training` 来代替 `model.eval()`，但两者不完全一样。

总之，我在之后的 script 中使用以下策略，成功地用 pre-convoluted features 训练出 98% 的模型：

```python
model = torchvision.models.resnet34(pretrained = True)
# wrong way       都怪这本破书教我这种小聪明
model = torch.nn.Sequential(*list(model.children())[:-1]) 
# correct way     简单粗暴，大智如愚
model.fc = torch.nn.Identity()
# or you can use `model.register_forward_hook()` to extract intermediate result

model.eval() # add this line before you calculate pre-convoluted features
```
