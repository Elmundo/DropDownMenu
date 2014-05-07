-- Includes
local display = require "display" 
local widget  = require "widget"

-- DropDownMenu Module
local DropDownMenu = {}

-- Constant Values
local cDefaultFontSize          = 16
local cDefaultFont              = "DefaultFont"
local cDefaultVisibleCellCount  = 4
local cDefaultCellXPadding      = 6
local cDefaultBorder            = 3
local cDefaultButtonValue       = "SEÇİNİZ"

-- PARAMS
--[[ params = {
        x = 0,
        y = 0,
        buttonWidth = width,
        buttonHeight = height,
        defaultImage = dImage,
        overImage = oImage,
        noLines = false,
        visibleCellCount = count,
        rowProperties = rowProperties,
        userCustomDataList = Array,
        ID = ID,
    }
--]]
--[[ cellData = {
        isCategory = false,
        rowHeight = rh,
        rowColor = { default={0.8, 0.8, 0.8}, , over={ 1, 0.5, 0, 0.2 }  }
        lineColor = {1,0,0},
    }
--]]

--[[ dataList = {
        value = value,
    }
--]]

function DropDownMenu.new( params )

    -- New DropDownMenu object
    local dropDownMenu  = display.newGroup()
    -----------------------------
    -- DropDownMenu Properties --
    -----------------------------
    -- Required --
    local name             = params.name
    local x                = params.x
    local y                = params.y
    local width            = params.width
    local height           = params.height
    local onRowSelected    = params.onRowSelected
    
    -- Optional --
    local buttonDefaultImageName = params.defaultImage     or nil
    local buttonOverImageName    = params.overImage        or nil
    local noLines                = params.noLines          or false
    local visibleCellCount       = params.visibleCellCount or cDefaultVisibleCellCount
    local fontSize               = params.fontSize         or cDefaultFontSize
    -----------------------------
    
    -- New Row Property object
    local rowProperties = params.rowProperties or {}
    -----------------------------
    --      Row Properties     --
    -----------------------------
    -- Optional --
    local isCategory       = rowProperties.isCategory or false
    local rowHeight        = rowProperties.rowHeight  or height
    local rowColor         = rowProperties.rowColor   or { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
    local lineColor        = rowProperties.lineColor  or { 0.5, 0.5, 0.5 }
    local labelFont        = nil
    local labelSize        = nil
    -----------------------------
    
    -----------------------------
    --        Data List        --
    -----------------------------
    local dataList = params.dataList or {}
    
    -- DDM Inner Properties
    local ddmTable       = nil
    local ddmTableBG     = nil
    -- Button Inner Properties
    local button         = nil
    local buttonBG       = nil
    local buttonLabel    = nil
    local buttonImage    = nil
    
    -- Flags
    local isButtonActive = false
    local ddmValue       = cDefaultButtonValue
    local isTableHidden  = true
    
    -----------------------------------------
    --       DDM Table Touch Events        --
    -----------------------------------------
    function dropDownMenu.onRowTouch( event )

        if event.phase == "press" then
            
        elseif event.phase == "release" then
            local params        = event.row.params
            local index         = event.row.index
            buttonLabel.text    = params.value
            dropDownMenu:hideTable(true)
            
            -- Invoke callback method
            onRowSelected{
                dataList[index],
                name,
                index,
            }
        end

    end

    function dropDownMenu.onRowRender( event )

        local row    = event.row
        local params = event.row.params

        local rowHeight = row.contentHeight
        local rowWidth  = row.contentWidth

        local rowTitle  = display.newText(row, params.value, 0, 0, rowWidth, rowHeight, nil, fontSize)
        rowTitle:setFillColor(0)

        row.contentHeight = row.contentHeight + rowTitle.height
        
        rowTitle.anchorY = 0.5
        rowTitle.x = 6
        rowTitle.y = (rowHeight * 0.5) + fontSize/2

    end
    
    ------------------------
    -- Instantiate Button --
    ------------------------
    local buttonWidth  = width + cDefaultBorder*2
    local buttonHeight = height + cDefaultBorder*2
    buttonBG = display.newRoundedRect(dropDownMenu, 
                                    -cDefaultBorder, 
                                    -cDefaultBorder, 
                                    buttonWidth, 
                                    buttonHeight, 
                                    5)                           
    buttonBG:setFillColor( 0.5, 0.5, 0.5 )
    
    -- Button object
    button = display.newRect(dropDownMenu, 0, 0, width, height)
    button:setFillColor( 1, 1, 1 )
    
    -- Button laber
    buttonLabel = display.newText(dropDownMenu, "CHOOSEN", 10, 10, buttonWidth, buttonHeight, nil, fontSize)
    buttonLabel:setFillColor(0)
    
    -----------------------
    -- Instantiate Table --
    -----------------------
    ddmTable = widget.newTableView{
        x = 0,
        y = buttonHeight + 2,
        width = buttonWidth,
        height = visibleCellCount * rowHeight,
        noLines = noLines,
        backgroundColor = { 1, 1, 1 },
        onRowTouch = dropDownMenu.onRowTouch,
        onRowRender = dropDownMenu.onRowRender,
    }
    
    ddmTableBG = display.newRoundedRect(-cDefaultBorder,
                                        rowHeight, 
                                        buttonWidth + cDefaultBorder*2, 
                                        (visibleCellCount * rowHeight) + cDefaultBorder*2, 
                                        5)
    ddmTableBG:setFillColor( 0.5, 0.5, 0.5 )
    
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTableBG)
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTable)
    dropDownMenu.x, dropDownMenu.y = x, y
    
    ---------------------------
    -- Instantiate ddm table --
    ---------------------------
    for i = 1, #dataList do
        local params = dataList[1]
        
        ddmTable:insertRow{
                         
                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = params
                          }
    end
    
    ------------------------------------------------------
    --                    METHOD LIST                   --
    ------------------------------------------------------
    function dropDownMenu:loadData(dataList)
        
        ddmTable:deleteAllRows()
        for i = 1, #dataList do
            local params = dataList[i]

            ddmTable:insertRow{
                                    isCategory = isCategory,
                                    rowHeight  = rowHeight,
                                    rowColor   = rowColor,
                                    lineColor  = lineColor,
                                    params     = params
                              }
        end
    end
    
    function dropDownMenu:insertRow(value)
        ddmTable:insertRow{

                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = {value = value}
                          }
    end
    
    function dropDownMenu:removeRow(value)
        ddmTable:deleteRow{

                                isCategory = isCategory,
                                rowHeight  = rowHeight,
                                rowColor   = rowColor,
                                lineColor  = lineColor,
                                params     = {value = value}
                          }
    end
    
    function dropDownMenu:hideTable(value)
        isTableHidden        = value
        ddmTable.isVisible   = not isTableHidden
        ddmTableBG.isVisible = not isTableHidden
        --delegate.didHideDDMTable( ID, isTableHidden)
    end
    
    function dropDownMenu:hideDDM ( isHidden)
        self.isVisible = not isHidden
    end
    
    -- Button Touch Methods --
    function dropDownMenu:touch(event)
        
        if event.phase == "began" then
        
        elseif event.phase == "moved" then
        
        elseif event.phase == "ended" then
            self:hideTable(not isTableHidden)
        end
        
        return true
    end
    
    function dropDownMenu:tap(event)
        return true
    end
    
    -- Catch the userInput event which is dispatched by native textfields
    local function hideDDMTable( event )
        dropDownMenu:hideTable(true)
    end
    
    -- GETTER & SETTER METHODS
    function dropDownMenu:getValue()
        return ddmValue
    end
    
    function dropDownMenu:updateButton( value )
        ddmValue = value 
        buttonLabel.text = ddmValue.Name
    end
    
    function dropDownMenu:setValue(value)
        ddmValue = value
    end
    
    -- Add Event Listeners
    dropDownMenu:addEventListener("touch", dropDownMenu)
    dropDownMenu:addEventListener("tap", dropDownMenu)
    -- Default visibilty of table is false
    dropDownMenu:hideTable(isTableHidden)
    function dropDownMenu.addListener()
        
        Runtime:addEventListener("userInput", hideDDMTable)
        Runtime:addEventListener("tap", hideDDMTable)
    end
    
    function dropDownMenu.destroy()
        Runtime:removeEventListener("userInput", hideDDMTable)
        Runtime:removeEventListener("tap", hideDDMTable)
    end
    
    return dropDownMenu
end


return DropDownMenu
