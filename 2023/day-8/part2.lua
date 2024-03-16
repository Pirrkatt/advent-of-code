-- Probably (?) works but takes too long to run, have to use other method
require("lib")

local input = GetInput("demo")

local cachedLines = {}
local positions = {}
local steps = 0

local function getLine(letters)
    if not cachedLines[letters] then
        for line, str in ipairs(input) do
            if str:match(letters .. " = ") then
                cachedLines[letters] = line
                break
            end
        end
    end
    return cachedLines[letters]
end

local function runLetters(dir)
    for _, data in ipairs(positions) do
        local left, right = input[data.num]:match("%((.*), (.*)%)")
        local line = (dir == "R" and getLine(right)) or getLine(left)
        local lastNode = input[line]:match("(..Z) = ")
        data.num = line
        data.done = (lastNode and true) or false
    end
end

local function checkCompletion()
    for _, v in ipairs(positions) do
        if not v.done then
            return false
        end
    end
    return true
end

local function hauntedWasteland()
    if #positions == 0 then
        for line, str in ipairs(input) do
            local validStart = str:match("..(A)")
            if validStart then
                local subTable = {num = line, done = false}
                table.insert(positions, subTable)
            end
        end
    end

    for direction in input[1]:gmatch("%u") do
        steps = steps + 1
        runLetters(direction)

        if checkCompletion() then
            return steps
        end
    end

    return hauntedWasteland()
end

print("How many steps does it take before you're only on nodes that end with Z?\nAnswer: " .. hauntedWasteland())
