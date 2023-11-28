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

local result = math.max(table.unpack(sumTable))
print("The Elf is carrying " .. result .. " calories in total!")
