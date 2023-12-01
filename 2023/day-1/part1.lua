require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local function getCalibrationValues()
    local result = {}

    for _, line in pairs(input) do
        local values = {}
        for digit in line:gmatch("%d") do
            table.insert(values, digit)
        end

        local number = #values == 1 and (values[1] .. values[1]) or (values[1] .. values[#values])
        table.insert(result, number)
    end

    return table.sum(result)
end

print("What is the sum of all of the calibration values?\nAnswer: " .. getCalibrationValues())