--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2021-01-03 14:36:55
]]
PlayerData = {}
PlayerData.equips = {}
PlayerData.items = {}
PlayerData.gems = {}

function PlayerData:Init()
    --一般游戏只会存储id和数量，其他的在本地进行读取
    
    table.insert(self.equips,{id = 1,num = 1})
    table.insert(self.equips,{id = 2,num = 1})
    
    table.insert(self.items,{id = 3,num = 50})
    table.insert(self.items,{id = 4,num = 20})

    table.insert(self.gems,{id = 5,num = 99})
    table.insert(self.gems,{id = 6,num = 88})
end


