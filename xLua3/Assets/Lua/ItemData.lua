--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2021-01-03 13:54:27
]]

--首先將json表 从AB包中加载出来
--加载Json文件 TextAsset对象
local txt = ABMgr:LoadRes("json","ItemData",typeof(TextAsset))
--获取他的文本信息，进行解析

local itemList = Json.decode(txt.text)
print("dededeed",txt.text)
--将数据进行二次封装,将json中的数据存储在lua表内
ItemData = {}
for _,value in pairs(itemList) do
    ItemData[value.id] = value
end
