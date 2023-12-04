require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local function checkAdjacentSymbols(length, row, column)
    local maxLength = #input[1]
    for i = math.max(1, row-1), math.min(#input, row+1) do
        local str = input[i]:sub(math.max(1, column-1), math.min(maxLength, column+length))
        local symbol = str:match("[^%d.]")
        if symbol then
            return true
        end
    end
    return false
end

local function engineSchematic()
    local partNumbers = {}

    for row, line in ipairs(input) do
        local searchFrom = 1
        for number in line:gmatch("%d+", searchFrom) do
            if checkAdjacentSymbols(#number, row, line:find(number, searchFrom)) then
                table.insert(partNumbers, number)
            end
            searchFrom = line:find(number, searchFrom) + #number
        end
    end

    return table.sum(partNumbers)
end

print("What is the sum of all of the part numbers in the engine schematic?\nAnswer: " .. engineSchematic())