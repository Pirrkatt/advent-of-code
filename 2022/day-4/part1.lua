require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent)

local totalPairs = 0
for _, v in pairs(t) do
    local first, second, third, fourth = string.match(v, "([%d]+)-([%d]+),([%d]+)-([%d]+)")
    first, second, third, fourth = tonumber(first), tonumber(second), tonumber(third), tonumber(fourth)

    if first >= third and second <= fourth then
        totalPairs = totalPairs + 1
    elseif third >= first and fourth <= second then
        totalPairs = totalPairs + 1
    end
end

print("In how many assignment pairs does one range fully contain the other?\nAnswer: " .. totalPairs)
