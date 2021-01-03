--获取Lua相关的
require("Object")
--字符串拆分
require("SplitTools")
--Json解析
Json = require("JsonUtility")

--Unity 相关
GameObject = CS.UnityEngine.GameObject
Resources = CS.UnityEngine.Resources
Transform = CS.UnityEngine.Transform
TextAsset = CS.UnityEngine.TextAsset

--图集相关的
SpriteAtlas = CS.UnityEngine.U2D.SpriteAtlas

Vector3 = CS.UnityEngine.Vector3
Vector2 = CS.UnityEngine.Vector2

--UI相关
UI = CS.UnityEngine.UI
Image = UI.Image
Text = UI.Text
Button = UI.Button
Toggle = UI.Toggle
ScrollRect = UI.ScrollRect

--Canvas 对于此项目来说，找一次就可以了
Canvas = GameObject.Find("Canvas").transform

--自己写的C#脚本相关
--直接得到单例对象，更加方便了
ABMgr = CS.ABMgr.GetInstance()
