--只要是一个新的对象（面板）我们那就新建一张表
MainPanel = {}

--不是必须写 因为lua的特性 不存在声明变量的概念
--这样写的目的 是当别人看这个lua代码时  知道这个表（对象）有什么变量很重要
--关联的面板对象
MainPanel.panelObj = nil
--对应的面板控件
MainPanel.btnRole = nil
MainPanel.btnSkill = nil

--需要做 实例化面板对象
--为这个面板 处理对应的逻辑 比如按钮点击等等

--初始化该面板 实例化对象 控件事件监听
function MainPanel:Init()
    --面板对象没有实例化过 才去实例化处理
    if self.panelObj == nil then
        --1.实例化面板对象 ABMgr + 设置父对象
        self.panelObj = ABMgr:LoadRes("ui", "MainPanel", typeof(GameObject))
        --是否保持缩放，不保持
        self.panelObj.transform:SetParent(Canvas, false)
        --2.找到对应控件 
        --找到子对象  再找到身上挂在的 想要的脚本
        self.btnRole = self.panelObj.transform:Find("btnRole"):GetComponent(typeof(Button))
        print(self.btnRole)
        --3.为控件加上事件监听  进行点击等等的逻辑处理
        --如果直接.传入自己的函数, 那么在函数BtnRoleClick内部 没有办法用self获取内容（这个时候print(self.panelObj)中的self其实是self.btnRole.onClick:AddListener去调的，self就是空，不是MainPanel调用的）
        --self.btnRole.onClick:AddListener(self.BtnRoleClick)--用冒号就等于调用了
        --所以需要用匿名函数，因为AddListener监听的是无参无返回值的，自己传进去一个即可，然后这个函数因为只是个普通函数，可以被AddListener调用，（有无self穿进去都行）这样就巧妙的避免了，
        self.btnRole.onClick:AddListener(function()
            self:BtnRoleClick()
        end)
    end
end
-- 这个self其实就是MainPanel，谁去调用它，谁就是MainPanel，上面self.btnRole.onClick:AddListener(self.BtnRoleClick)内部调用的话，那么self就不是mainPanel了，所以内部的self就不对
-- 这样写其实可以用MainPanel.panelObj,这样也可以，但是不符合面向对象思想
--通过匿名内部内，就可以不直接传进去self.BtnRoleClick，而是又一层封装，此时的
function MainPanel:BtnRoleClick()
    print(123123)
    print(self.panelObj,BagPanel)
    --等我们写了背包面板 
    --在这显示我们的 背包面板
    BagPanel:ShowMe()
end
function MainPanel:ShowMe()
    self:Init()
    self.panelObj:SetActive(true)
end

function MainPanel:HideMe()
    self.panelObj:SetActive(false)
end
