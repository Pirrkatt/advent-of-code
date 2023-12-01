require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local words = {
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
}

local function getIndex(t)
    local lowest
    local highest

    for k,_ in pairs(t) do
        lowest = lowest and math.min(lowest, k) or k
        highest = highest and math.max(highest, k) or k
    end

    return t[lowest] .. t[highest]
end

local function getCalibrationValues()
    local result = {}

    for _, line in pairs(input) do
        local values = {}
        local init = 1

        for digit in line:gmatch("%d", init) do
            init = line:find(digit, init)
            values[init] = tonumber(digit)
        end

        for letter, word in ipairs(words) do
            init = 1
            for digit in line:gmatch(word, init) do
                init = line:find(digit, init)
                values[init] = letter
            end
        end

        table.insert(result, getIndex(values))
    end

    return table.sum(result)
end

print("What is the sum of all of the calibration values?\nAnswer: " .. getCalibrationValues())
