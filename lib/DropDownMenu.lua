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
        cellData = cellData,
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

function DropDownMenu.new( params )

    -- New DropDownMenu object
    local dropDownMenu  = display.newGroup()
    
    local cellData         = params.cellData or {}
    local x                = params.x
    local y                = params.y
    local noLines          = params.noLines
    local visibleCellCount = params.visibleCellCount or cDefaultVisibleCellCount
    local parent           = params.parent
    local delegate         = params.delegate
    local ID               = params.ID
    local customParams     = params.customParams
    local fontSize         = params.fontSize or cDefaultFontSize
    --parent:insert(dropDownMenu)
    
    -- Properties
    local ddmTable       = nil
    local ddmTableBG     = nil
    local button         = nil
    local buttonBG       = nil
    local buttonLabel    = nil
    
    local ddmValue       = cDefaultButtonValue
    local isTableHidden = true
    
    -- Button Properties
    local buttonImage               = nil
    local buttonDefaultImageName    = (params.defaultImage or nil)
    local buttonOverImageName       = (params.overImage    or nil)
    local buttonWidth               = (params.buttonWidth  or 360)
    local buttonHeight              = (params.buttonHeight or 40)
    local isButtonActive            = false
    
    -- Cell Properties
    local isCategory    = cellData.isCategory or false
    local rowHeight     = cellData.rowHeight  or buttonHeight
    local rowColor      = cellData.rowColor   or { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
    local lineColor     = cellData.lineColor  or { 0.5, 0.5, 0.5 }
    local cellHeight    = cellData.rowHeight  or buttonHeight
    local cellWidth     = buttonWidth
    
    -- User Data List Property
    local dataList = params.dataList or {}
    
    dropDownMenu.x, dropDownMenu.y = x, y
    
    -- Instantiate Button
    buttonBG = display.newRoundedRect(dropDownMenu, -cDefaultBorder, -cDefaultBorder, buttonWidth + cDefaultBorder*2, buttonHeight + cDefaultBorder*2, 5)
    buttonBG:setFillColor( 0.5, 0.5, 0.5 )
    
    button = display.newRect(dropDownMenu, 0, 0, buttonWidth, buttonHeight)
    button:setFillColor( 1, 1, 1 )
    
    buttonLabel = display.newText(dropDownMenu, "SEÇİNİZ", 10, 10, buttonWidth, buttonHeight, nil, fontSize)
    buttonLabel:setFillColor(0)
    
    -- Table Delegate - Touch Events
    function dropDownMenu.onRowTouch( event )

        if event.phase == "press" then
            
        elseif event.phase == "release" then
            local params        = event.row.params
            local index         = event.row.index
            local ID            = ID
            ddmValue            = params.value
            buttonLabel.text    = ddmValue
            dropDownMenu:hideTable(true)
            
            -- Call delegate method
            delegate.didDDMItemSelected(dataList[index], ID, index)
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
    
     -- Instantiate Table
    ddmTableBG = display.newRoundedRect(-cDefaultBorder,cellHeight, buttonWidth + cDefaultBorder*2, (visibleCellCount * cellHeight) + cDefaultBorder*2, 5)
    ddmTableBG:setFillColor( 0.5, 0.5, 0.5 )
    
    ddmTable = widget.newTableView{
        width = buttonWidth,
        height = visibleCellCount * cellHeight,
        x = 0,
        y = buttonHeight + 2,
        
        noLines = (noLines or true),
        backgroundColor = { 1, 1, 1 },
        
        onRowTouch = dropDownMenu.onRowTouch,
        onRowRender = dropDownMenu.onRowRender,
    }
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTableBG)
    dropDownMenu:insert(dropDownMenu.numChildren+1, ddmTable)
    
    --Instantiate ddm table
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
    
    -- Drop Down Menu Methods
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
        delegate.didHideDDMTable( ID, isTableHidden)
    end
    
    function dropDownMenu:hideDDM ( isHidden)
        self.isVisible = not isHidden
    end
    
    -- Button Touch Methods
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
        --[[]
        local params        = event.row.params
        local index         = event.row.index
        local ID            = ID
        ddmValue            = params.value
        buttonLabel.text    = ddmValue
        dropDownMenu:hideTable(true)
        --]]
        ddmValue = value
    end
    
    function dropDownMenu:setID(id)
        ID = id
    end
    
    -- Add event listeners
    
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
