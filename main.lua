require "CiderDebugger";
local DDM = require "lib.DropDownMenu"
local display = require "display"
local RowData = require "lib.RowData"
-- Set default anchor point of project top-left
display.setDefault("background", 1,1,1)
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

-- Test Row Data
local datas = {}

for i=1, 20 do
    local rowData = RowData.new("istanbul " .. i, 
                                {
                                    ID = i,
                                    description = "This is description of the selected county index by\n " .. i,
                                })
    datas[i] = rowData
end

local resultText = display.newText("Test String", 0, 0, 200, 200, native.systemFont, 16)
resultText:setFillColor(1,0,0)

local testDDM = DDM.new({
    name = "testDDN",
    x = 100,
    y = 100,
    width = 200,
    height = 40,
    dataList = datas,
    onRowSelected = function (name, rowData)
        if name == "testDDN" then
            local rowData = rowData
            resultText.text = rowData.description
        end 
    end
    
})
