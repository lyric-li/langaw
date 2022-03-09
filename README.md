# langaw

> 基于 Flutter 和 Flame 实现的`拍苍蝇`小游戏

## 背景

学习 Flutter 的练习项目，该项目的核心逻辑和素材出自 [awesome-flame项目中Alekhin的初学者教程系列](https://jap.alekhin.io/create-mobile-game-flutter-flame-beginner-tutorial)

## 我做了哪些工作
- 适配 Flutter 2.10.1
- 适配健全的空安全机制
- 升级 Flame 版本到 1.0.0 正式版，并解决 API 不适配问题
- 修复倒计时不准确的问题
- 改进玩法，击落不同类型的飞蝇得分不同
- 增加了资源加载的过渡页

## 玩法

游戏开始后，会随机生成飞行速度不同的苍蝇，同屏最多 5 只。每只苍蝇都拥有独立的倒计时，在倒计时结束前击落累计得分，没击中或倒计时结束，则游戏结束。

## 预览

![preview](./screenshot/preview.gif)
