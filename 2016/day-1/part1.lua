require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local directions = {
    ["N"] = {x = 0, y = -1},
    ["E"] = {x = 1, y = 0},
    ["S"] = {x = 0, y = 1},
    ["W"] = {x = -1, y = 0}
}

local dirs = {"N", "E", "S", "W"}
local currentDir = 1 -- Start facing north
local x, y = 0, 0

local function updatePosition(dir, length)
    x = x + directions[dir].x * length
    y = y + directions[dir].y * length
end

local function calculateDistance(input)
    for turn, length in string.gmatch(input, "(%a)(%d+)") do
        length = tonumber(length)
        if turn == "R" then
            currentDir = (currentDir % 4) + 1
        elseif turn == "L" then
            currentDir = (currentDir - 2) % 4 + 1
        end
        updatePosition(dirs[currentDir], length)
    end
    return math.abs(x) + math.abs(y)
end

local input = getInput()
local distance = calculateDistance(input)

print("How many blocks away is Easter Bunny HQ?\nAnswer: " .. distance)