require "CiderDebugger";
local DDM = require "lib.DropDownMenu"
local display = require "display"

-- Set default anchor point of project top-left
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

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
    {value = "istanbul"},
    {value = "istanbul2"},
    {value = "istanbul3"},
    {value = "istanbul4"},
    {value = "istanbul5"},
    {value = "istanbul6"},
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
        
    end
    
})
