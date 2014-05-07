require "CiderDebugger";
local DDM = require "lib.DropDownMenu"

local cellData = {
    isCategory = false,
    rowheight = 40,
    rowColor = { default={0.8, 0.8, 0.8}, over={ 1, 0.5, 0, 0.2 } },
    lineColor = {1,0,0},
}

local datas = {
    {value = "istanbul"},
    {value = "istanbul2"},
    {value = "istanbul3"},
    {value = "istanbul4"},
    {value = "istanbul5"},
    {value = "istanbul6"},
}

local testDDM = DDM.new({
    name = "testDDN",
    x = 100,
    y = 100,
    width = 200,
    height = 40,
    dataList = datas,
    onRowSelected = function (params)
        print("" .. params.value)
    end
    
})
