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

local groups = {}
local groupIndex = 1
local commonCharacters = {}
for k, v in pairs(t) do
    if not groups[groupIndex] then
        groups[groupIndex] = {}
    end

    table.insert(groups[groupIndex], v)
    if k%3 == 0 then
        groupIndex = groupIndex + 1
    end
end

local function checkGroup(character, group)
    if string.find(group[1], character) and string.find(group[2], character) and string.find(group[3], character) then
        return true
    end
    return false
end

for group,_ in pairs(groups) do
    local found = false
    for _, individualValue in pairs(groups[group]) do
        for i = 1, #individualValue do
            local character = string.sub(individualValue, i, i)
            found = checkGroup(character, groups[group])
            if found then
                table.insert(commonCharacters, character)
                break
            end
        end
        if found then
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
