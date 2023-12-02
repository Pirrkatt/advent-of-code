require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local colors = {"red", "green", "blue"}

local function getSetPower(table)
    local power = 1
    for _, v in pairs(table) do
        power = power * v
    end
    return power
end

local function cubeGame()
    local gamePowers = {}

    for _, line in ipairs(input) do
        local currentSet = {}

        for _, color in pairs(colors) do
            for amount in line:gmatch("(%d+) " .. color) do
                currentSet[color] = math.max(currentSet[color] or 0, tonumber(amount))
            end
        end

        table.insert(gamePowers, getSetPower(currentSet))
    end

    return table.sum(gamePowers)
end

print("What is the sum of the power of these sets?\nAnswer: " .. cubeGame())