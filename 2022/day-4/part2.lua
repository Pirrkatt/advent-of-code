require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent)

local totalPairs = 0
for _, v in pairs(t) do
    local first, second, third, fourth = string.match(v, "([%d]+)-([%d]+),([%d]+)-([%d]+)")
    first, second, third, fourth = tonumber(first), tonumber(second), tonumber(third), tonumber(fourth)

    for i = first, second do
        local found = false
        local num = i
        for j = third, fourth do
            if j == num then
                found = true
                break
            end
        end
        if found then
            totalPairs = totalPairs + 1
            break
        end
    end
end

print("In how many assignment pairs do the ranges overlap?\nAnswer: " .. totalPairs)
