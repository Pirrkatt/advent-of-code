require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")
local sumTable = {}
local index = 1

for _, v in pairs(t) do
    if tonumber(v) ~= nil then
        sumTable[index] = (sumTable[index] or 0) + tonumber(v)
    else
        index = index + 1
    end
end

local result = 0
for i = 1, 3 do
    local max = math.max(table.unpack(sumTable))

    for k, v in pairs(sumTable) do
        if v == max then
            table.remove(sumTable, k)
        end
    end
    result = result + max
end
print("The top three Elves are carrying " .. result .. " calories in total!")
