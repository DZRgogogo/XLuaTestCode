print("准备就绪")
--初始化所有准备好的类
require("InitClass")
--初始化道具表
require("ItemData")
--玩家信息
--1、从本地读取，本地存储有几种方式 PlayerPrefs 和 Json 或者 二进制
--2、网络游戏 从服务器中获取
require("PlayerData")
PlayerData:Init()
require("BagPanel")
require("MainPanel")
MainPanel:ShowMe()