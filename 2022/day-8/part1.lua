require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

-- Find #trees VISIBLE
-- Check up, down, left, right only
-- Lower number = Visible

local visible = 0

local function visibleAdjacent(str, row, tree, index)
    local directionValues = {up = {}, down = {}, left = {}, right = {}}

    -- Insert elements from rows
    for k, v in pairs(t) do
        if k ~= row then
            if k < row then
                table.insert(directionValues.up, string.sub(v, index, index))
            else
                table.insert(directionValues.down, string.sub(v, index, index))
            end
        end
    end

    -- Insert elements from columns
    for i = 1, #str do
        if i ~= index then
            if i < index then
                table.insert(directionValues.left, string.sub(str, i, i))
            else
                table.insert(directionValues.right, string.sub(str, i, i))
            end
        end
    end

    for _,dir in pairs(directionValues) do
        local dirMax = math.max(table.unpack(dir))
        if tonumber(tree) > tonumber(dirMax) then
            return true
        end
    end
    return false
end

local function treeHouse()
    for k, v in pairs(t) do
       if k == 1 or k == #t then -- First and last row are all visible
            visible = visible + #v
       else
            for i = 2, #v-1 do
                local tree = string.sub(v, i, i)
                if visibleAdjacent(v, k, tree, i) then
                    visible = visible + 1
                end
            end
            visible = visible + 2 -- First and last column are always visible
        end
    end
    return visible
end

print("How many trees are visible from outside the grid?\nAnswer: " .. treeHouse())