
-- RowData Module
local RowData = {}

-- Constant Default Values
local cDefaultRowValue = "Default Value"

function RowData.new(value, params)
    
    -- Newly created row object
    local rowData = {}
    
    -- Required Property
    rowData.value = value
    
    -- Optional Dynamic Properties
    for k,v in pairs(params) do
        rowData[k] = v
    end
    
    return rowData
end

return RowData

