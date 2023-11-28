require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

local function checkView(str, row, tree, index)
    local directionValues = {up = {}, down = {}, left = {}, right = {}}

    for i = row-1, 1, -1 do -- Up
        local num = tonumber(string.sub(t[i], index, index))
        table.insert(directionValues.up, num)
        if num >= tree then
            break
        end
    end

    for i = row+1, #t do -- Down
        local num = tonumber(string.sub(t[i], index, index))
        table.insert(directionValues.down, num)
        if num >= tree then
            break
        end
    end

    for i = index-1, 1, -1 do -- Left
        local num = tonumber(string.sub(str, i, i))
        table.insert(directionValues.left, num)
        if num >= tree then
            break
        end
    end

    for i = index+1, #str do -- Right
        local num = tonumber(string.sub(str, i, i))
        table.insert(directionValues.right, num)
        if num >= tree then
            break
        end
    end

    return (#directionValues.up * #directionValues.down * #directionValues.left * #directionValues.right)
end

local function treeHouse()
    local scenicScore = 0

    for k, v in pairs(t) do
       if k ~= 1 and k ~= #t then -- First and last row are all visible
            for i = 2, #v-1 do
                local tree = tonumber(string.sub(v, i, i))
                scenicScore = math.max(scenicScore, checkView(v, k, tree, i))
            end
        end
    end
    return scenicScore
end

print("How many trees are visible from outside the grid?\nAnswer: " .. treeHouse())