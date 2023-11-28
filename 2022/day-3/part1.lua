require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent)

local priorities = {}
for i = 1, 2 do
    local a = 'a'
    local z = 'z'
    if i == 2 then
        a, z = a:upper(), z:upper()
    end

    for ascii = string.byte(a), string.byte(z) do
        table.insert(priorities, string.char(ascii))
    end
end

local commonCharacters = {}
for _, v in pairs(t) do
    local half = string.len(v) / 2

    local first = string.sub(v, 0, half)
    local second = string.sub(v, half + 1)

    for i = 1, #first do
        local character = string.sub(first, i, i)
        if string.find(second, character) then
            table.insert(commonCharacters, character)
            break
        end
    end
end

local totalSum = 0
for _, char in pairs(commonCharacters) do
    for k, v in pairs(priorities) do
        if char == v then
            totalSum = totalSum + k
        end
    end
end

print("Sum of priorities: " .. totalSum)
