require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

local x = 1
local totalCycles = 0
local cycleValues = {noop = 1, addx = 2}
local signalStrengths = {}

local function checkSignals()
    local checkCycles = 20 + (40 * #signalStrengths)
    if totalCycles == checkCycles then
        table.insert(signalStrengths, totalCycles * x)
    end
end

local function runCycles()
    local currentCycle = 0
    for _, v in pairs(t) do
        local noop = string.match(v, "noop")
        local add = string.match(v, "addx (-?%d+)")

        if noop then
            currentCycle = currentCycle + cycleValues.noop
            totalCycles = totalCycles + cycleValues.noop
            checkSignals()
        else
            for i = 1, cycleValues.addx do
                currentCycle = currentCycle + 1
                totalCycles = totalCycles + 1
                checkSignals()
            end
            x = x + add
        end
    end
    return table.sum(signalStrengths)
end

print("What is the sum of these six signal strengths?\nAnswer: " .. runCycles())
