require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local function getWholeNumber(row, column)
    local str = input[row]
    local startIndex = 0
    local i = 0

    while str:sub(column - i, column - i):match("%d") do
        startIndex = column - i
        i = i + 1
    end

    local number = str:match("%d+", startIndex)
    return tonumber(number), row, startIndex
end

local function checkAdjacentNumbers(row, column)
    local numbers = {}

    local maxLength = #input[1]
    for i = math.max(1, row-1), math.min(#input, row+1) do
        for j = -1, 1 do
            local str = input[i]:sub(math.max(1, column+j), math.min(maxLength, column+j))
            local symbol = str:match("%d")
            if symbol then
                local number, r, c = getWholeNumber(i, column+j)
                local tbl = {number = number, r = r, c = c}
                if #numbers > 0 and numbers[#numbers].number ~= tbl.number or #numbers == 0 then -- Could potentially cause problems if 2 numbers are the same
                    table.insert(numbers, tbl)
                end
            end
        end
    end

    return (#numbers == 2 and numbers[1].number * numbers[2].number) or false
end

local function getGearRatios()
    local gearRatios = {}

    for row, str in ipairs(input) do
        local index = 1
        for gear in str:gmatch("*", index) do
            local numbers = checkAdjacentNumbers(row, str:find(gear, index))
            if numbers then
                table.insert(gearRatios, numbers)
            end
            index = str:find(gear, index) + 1
        end
    end

    return table.sum(gearRatios)
end

print("What is the sum of all of the gear ratios in your engine schematic?\nAnswer: " .. getGearRatios())