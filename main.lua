require "CiderDebugger";
local display = require "display"
local DDM     = require "lib.DropDownMenu"
local RowData = require "lib.RowData"
-- Set default anchor point of project top-left
display.setDefault("background", 1,1,1)
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

print("Device width: " .. display.pixelWidth) 
print("Device height: " .. display.pixelHeight)

---------------------
-- Hard-coded Data --
--------------------- 
-- Detail Test Data
local detailTextStr = [==[When the system went out, air traffic controllers working in the regional center switched to a back-up system so they could see the planes on their screens, according to one of the sources.

Paper slips and telephones were used to relay information about planes to other control centers.

The ERAM system failed because it limits how much data each plane can send it, according to the sources. Most planes have simple flight plans, so they do not exceed that limit.

But a U-2 operating at high altitude that day had a complex flight plan that put it close to the system's limit, the sources said.

The plan showed the plane going in and out of the Los Angeles control area multiple times, not a simple point-to-point route like most flights, they said. ]==]

-- Province DDM Row Data
local provinceData = {"ISTANBUL","ANKARA","IZMIR","ADANA","BATMAN","RIZE","KONYA","CANAKKALE","NIGDE","SAMSUN","BOLU","IZMIT"}
for i=1, #provinceData do
    local rowData = RowData.new(provinceData[i], 
                                {ID = i, description = "This is description of the selected county index by\n " .. i,})
    provinceData[i] = rowData
end

-- Color DDM Row Data
local colorData = {"Red", "Green", "Blue", "White"}
for j=1, #colorData do
    local rowData = RowData.new(colorData[j], {ID=j})
    colorData[j] = rowData
end

-- Drop Down Menu Header
local header = display.newText("Drop Down Menu", display.contentCenterX, 10, 0, 0, native.systemFontBold, 38)
header.anchorX = 0.5
header:setFillColor(0.5,0.5,0.5)

-- Detail Text Background
local detailTextBG = display.newRoundedRect(500, 100, 492, 472, 5)
detailTextBG:setFillColor(0.2, 0.2, 0.2)

-- Detail Text
local detailText = display.newText(detailTextStr, 510, 110, 480, 470, native.systemFont, 16)
detailText:setFillColor(1,0,0)

-- Province Header
local provinceHeader = display.newText("Province List", 50, 80, 480, 470, native.systemFont, 16)
provinceHeader:setFillColor(1,0.5,0)

-- Color Header
local colorHeader = display.newText("Text Color List", 50, 180, 480, 470, native.systemFont, 16)
colorHeader:setFillColor(1,0.5,0)

-------------------------
-- DROP DOWN MENU INIT --
------------------------- 
local function onRowSelected(name, rowData)
        if name == "provinces" then
            local rowData = rowData
            detailText.text = rowData.value .. ": " .. detailTextStr
            
        elseif name == "textcolor" then
            local rowData = rowData
            if rowData.value == "Red" then
                detailText:setFillColor(1,0,0)
            elseif rowData.value == "Green" then
                detailText:setFillColor(0,1,0)
            elseif rowData.value == "Blue" then
                detailText:setFillColor(0,0,1)
            elseif rowData.value == "White" then
                detailText:setFillColor(1,1,1)
            end
        end
end
    
local textColorDDM = DDM.new({
    name = "textcolor",
    x = 50,
    y = 200,
    width = 200,
    height = 40,
    dataList = colorData,
    onRowSelected = onRowSelected,
})

local provinceDDM = DDM.new({
    name = "provinces",
    x = 50,
    y = 100,
    width = 200,
    height = 40,
    dataList = provinceData,
    onRowSelected = onRowSelected,
})


