---
title: 机器学习算法--kNN
date: 2020-01-01 09:54:07
updated: 2020-01-01 09:54:07
tags: knn
categories: machine-learning
keywords:
description:
top_img:
comments:
cover: https://image.holynlp.com/2020-09-01-064257.jpg
toc:
toc_number:
auto_open:
copyright:
copyright_author:
copyright_author_href:
copyright_url:
copyright_info:
mathjax:
aplayer:
highlight_shrink:
---

### 1. kNN算法的基本原理
> k近邻算法（分类）： 当输入一个新的值x的时候，根据与x最近的k个点的类别来判断x属于什么类别。

### 2. 何为距离--距离度量表示法

机器学习中常见的几种度量距离的公式包括以下几个

参考自[机器学习中距离和相似性度量的方法](https://zhuanlan.zhihu.com/p/40020663)

- **闵可夫斯基距离**
- **欧几里得距离**
- **曼哈顿距离**
- **切比雪夫距离**
- **马氏距离**
- **余弦相似度**
- **皮尔逊相关系数**
- **汉明距离**
- **杰卡德相似系数**
- **编辑距离**
- **DTW 距离**
- **KL 散度**

### 3. k值该如何选取呢？

k值过小：

k值过大：

对折交叉验证

### 4. kNN的优缺点

kNN的特点：

* 非参
* 惰性

kNN的优点:

* 原理简单，易用
*  模型训练时间快，或者叫没有明确的训练过程
* 预测效果好
* 对异常值不敏感

kNN的缺点：

* 对内存要求较高，内存存储所有的训练数据
* 预测阶段很慢（）
* 对不相关的功能和数据规模敏感

### 4. 手动实现kNN

[见GitHub](https://github.com/LesterHoly/ml_study/tree/master/knn)

### 5. kd树原理
### 6. kd树实现
### 7. sk-learn中的knn
### 8. sk-learn应用knn
