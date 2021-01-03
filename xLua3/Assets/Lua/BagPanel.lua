--一个面板对应一个表
BagPanel = {}
--"成员变量"
--面板对象
BagPanel.panelObj = nil
--各个控件
BagPanel.btnClose = nil
BagPanel.togEquip = nil
BagPanel.togItem = nil
BagPanel.togGem = nil
BagPanel.svBag = nil
BagPanel.Content = nil
--用来存储当前 显示的格子
BagPanel.items = {}
--用来存储当前显示的页签 类型 避免重复刷新
BagPanel.nowType = -1

--"成员方法"
--初始化方法
function BagPanel:Init()

    if self.panelObj == nil then
         --实例化面板对象
        self.panelObj = ABMgr:LoadRes("ui", "BagPanel", typeof(GameObject))
        self.panelObj.transform:SetParent(Canvas, false)
        --找控件
        --关闭按钮
        self.btnClose = self.panelObj.transform:Find("btnClose"):GetComponent(typeof(Button))
        --找3个toggle
        local group = self.panelObj.transform:Find("Group")
        self.togEquip = group:Find("togEquip"):GetComponent(typeof(Toggle))
        self.togItem = group:Find("togItem"):GetComponent(typeof(Toggle))
        self.togGem = group:Find("togGem"):GetComponent(typeof(Toggle))
        --sv相关
        self.svBag = self.panelObj.transform:Find("svBag"):GetComponent(typeof(ScrollRect))
        self.Content = self.svBag.transform:Find("Viewport"):Find("Content")
        --加事件
        --关闭按钮
        self.btnClose.onClick:AddListener(function()
            self:HideMe()
        end)
        --单选框事件
        --切页签
        --toggle 对应委托 是 UnityAction<bool>
        self.togEquip.onValueChanged:AddListener(function(value)
            if value == true then
                self:ChangeType(1)
            end
        end)
        self.togItem.onValueChanged:AddListener(function(value)
            if value == true then
                self:ChangeType(2)
            end
        end)
        self.togGem.onValueChanged:AddListener(function(value)
            if value == true then
                self:ChangeType(3)
            end
        end)
    end
   
end
--显示隐藏
function BagPanel:ShowMe()
    self:Init()
    self.panelObj:SetActive(true)
    --第一次打开是 更新数据
    if self.nowType == -1 then
        self:ChangeType(1)
    end
end
function BagPanel:HideMe()
    self.panelObj:SetActive(false)
end

--逻辑处理函数 用来切页签的
--type 1装备 2道具 3宝石
function BagPanel:ChangeType(type)
    --判断如果已经是该页签 就别更新了
    if self.nowType == type then
        return
    end
    --切页  根据玩家信息 来进行格子创建

    --更新之前 把老的格子删掉 BagPanel.items
    for i = 1, #self.items do
        --销毁格子对象
        GameObject.Destroy(self.items[i].obj)
    end
    self.items = {}

    --再根据当前选择的类型 来创建新的格子 BagPanel.items
    --要根据 传入的 type 来选择 显示的数据
    local nowItems = nil
    if type == 1 then
        nowItems = PlayerData.equips
    elseif type == 2 then
        nowItems = PlayerData.items
    else
        nowItems = PlayerData.gems
    end

    --创建格子
    for i = 1, #nowItems do
        --有格子资源 在这 加载格子资源 实例化 改变图片 和 文本 以及位置即可
        local grid = {}
        --用一张新表 代表 格子对象 里面的属性 存储对应想要的信息
        grid.obj = ABMgr:LoadRes("ui", "ItemGrid");
        --设置父对象
        grid.obj.transform:SetParent(self.Content, false)
        --继续设置他的位置
        grid.obj.transform.localPosition = Vector3((i-1)%4 * 175, math.floor((i-1)/4)*175, 0)
        --找控件
        grid.imgIcon = grid.obj.transform:Find("imgIcon"):GetComponent(typeof(Image))
        print("HAHHA ",grid.obj.transform)
        grid.Text = grid.obj.transform:Find("Text"):GetComponent(typeof(Text))
        --设置它的图标
        --通过 道具ID 去读取 道具配置表 得到 图标信息
        local data = ItemData[nowItems[i].id]
        print("HAHHA111 ",ItemData,nowItems[i].id,ItemData[nowItems[i].id])
        print("HAHHA1222 ",data.icon)
        --想要的是data中的 图标信息
        --根据名字 先加载图集 再加载图集中的 图标信息
        local strs = string.split(data.icon, "_")
        --加载图集
        local spriteAtlas = ABMgr:LoadRes("ui", strs[1], typeof(SpriteAtlas))
        --加载图标
        grid.imgIcon.sprite = spriteAtlas:GetSprite(strs[2])
        --设置它的数量
        grid.Text.text = nowItems[i].num

        --把它存起来
        table.insert(self.items, grid)
    end
end