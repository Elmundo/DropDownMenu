Drop-Down Menu
==============

**Dropdown Menu** is a web-style component which is developed in **Corona SDK** that there is no built drop-down menu structure in iOS and Android platforms. With DDM module, you could create exactly the same as a web site DropdownMenu (DropdownList). It is not suitable for small-screen mobile devices because of its design and size but could be useful for iPad and Andorid tablets.  

> It is required you to be familiar with both Corona SDK and Lua programming language.

I am used to have the origin point (anchor point) as top-left of the display objects, but corona default is not designed like this (except the scenes objects) which use middle of the display objects as origin point. The code below which is added to main.lua arrange anchor point as top-left for all display objects.

``` lua
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
```

It is a matter of choice to use code above, but don’t forget to arrange it for all display objects accordingly.

Examples
--------

### *Simple Usage*
``` lua
-- DropDownMenu module
local DDM = require "lib.DropDownMenu"
local RowData = require "lib.RowData"

-- Color DDM Row Data
local colorData = {"Red", "Green", "Blue", "White"}
for i=1, #colorData do
    local rowData = RowData.new(colorData[j], {ID=i})
    colorData[j] = rowData
end

local function onRowSelected(name, rowData)
        if name == "colors" then
            print("Selected color is " .. rowData.value)
        end
end

local colorDDM = DDM.new({
                          name = "colors",
                          x = 50,
                          y = 100,
                          width = 200,
                          height = 40,
                          dataList = colorData,
                          onRowSelected = onRowSelected  })
                        
```
### *Advanced Usage*
**Comming soon..**

There is also a sample project in repo where you could see the whole usage of the Drop Down Menu through a simple project.

I hope this works for you.
