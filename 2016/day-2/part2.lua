require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local keypad = {
    {nil, nil, "1", nil, nil},
    {nil, "2", "3", "4", nil},
    {"5", "6", "7", "8", "9"},
    {nil, "A", "B", "C", nil},
    {nil, nil, "D", nil, nil},
}
local x, y = 1, 3 -- Start at number 5

local function isValidPosition(newX, newY)
    if newX < 1 or newX > 5 or newY < 1 or newY > 5 then
        return false
    end
    return keypad[newY][newX] ~= nil
end

local function moveOnKeypad(dir)
    local newX, newY = x, y
    if dir == "U" then
        newY = y - 1
    elseif dir == "L" then
        newX = x - 1
    elseif dir == "D" then
        newY = y + 1
    elseif dir == "R" then
        newX = x + 1
    end
    if isValidPosition(newX, newY) then
        x, y = newX, newY
    end
end

local function decipherCode(input)
    local result = ""

    for _, line in ipairs(input) do
        for dir in string.gmatch(line, "%a") do
            moveOnKeypad(dir)
        end
        result = result .. keypad[y][x]
    end
    return result
end

local input = getInput()
local code = decipherCode(input)

print("Using the same instructions in your puzzle input, what is the correct bathroom code?\nAnswer: " .. code)