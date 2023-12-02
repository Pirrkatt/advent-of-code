require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local colors = {["red"] = 12, ["green"] = 13, ["blue"] = 14}

local function cubeGame()
    local totalSum = 0

    for _, line in ipairs(input) do
        local gameId = line:match("Game (%d+)")
        local valid = true

        for color, max in pairs(colors) do
            for amount in line:gmatch("(%d+) " .. color) do
                if tonumber(amount) > max then
                    valid = false
                    break
                end
            end
        end

        if valid then
            totalSum = totalSum + gameId
        end
    end

    return totalSum
end

print("What is the sum of the IDs of those games?\nAnswer: " .. cubeGame())