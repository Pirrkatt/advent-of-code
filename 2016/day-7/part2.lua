require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local function hasMatchingBAB(aba, hypernets)
    local bab = aba:sub(2, 2) .. aba:sub(1, 1) .. aba:sub(2, 2)
    for _, hypernet in ipairs(hypernets) do
        if hypernet:find(bab) then
            return true
        end
    end
    return false
end

local function isABA(str)
    return #str == 3 and (str:sub(1, 1) == str:sub(3, 3) and str:sub(1, 1) ~= str:sub(2, 2))
end

local function checkSSL(str, hypernets)
    for i = 1, #str-2 do
        local aba = str:sub(i, i+2)
        if isABA(aba) and hasMatchingBAB(aba, hypernets) then
            return true
        end
    end
    return false
end

local function supportsSSL(str)
    local hypernets = {}
    for hypernet in str:gmatch("%[(%l+)%]") do
        table.insert(hypernets, hypernet)
    end

    local outsideSegments = str:gsub("%[%l+%]", " ")

    for str in outsideSegments:gmatch("%l+") do
        if checkSSL(str, hypernets) then
            return true
        end
    end
    return false
end

local function run(input)
    local count = 0
    for _, line in ipairs(input) do
        if supportsSSL(line) then
            count = count + 1
        end
    end

    return count
end

local input = getInput()
local answer = run(input)

print("How many IPs in your puzzle input support SSL?\nAnswer: " .. answer)

-- Cache current hypernet sequences in a table
-- Go through each letters 3 at a time and check the cache for corresponding pair
