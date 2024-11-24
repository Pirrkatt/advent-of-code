require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local keypad = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
}
local rows = #keypad
local columns = #keypad[1]
local x, y = 2, 2 -- Start at number 5

local function moveOnKeypad(dir)
    if dir == "U" then
        y = math.max(1, math.min(rows, y - 1))
    elseif dir == "L" then
        x = math.max(1, math.min(columns, x - 1))
    elseif dir == "D" then
        y = math.max(1, math.min(rows, y + 1))
    elseif dir == "R" then
        x = math.max(1, math.min(columns, x + 1))
    end
    return keypad[y][x]
end

local function decipherCode(input)
    local result = ""

    for _, line in ipairs(input) do
        local currentNumber
        for dir in string.gmatch(line, "%a") do
            currentNumber = moveOnKeypad(dir)
        end
        result = result .. currentNumber
    end
    return result
end

local input = getInput()
local code = decipherCode(input)

print("What is the bathroom code?\nAnswer: " .. code)