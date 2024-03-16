require("lib")

local input = GetInput("demo")

-- # has to be filled

local function countSymbols()
    local t = {}
    local currentStr = ""
    for i = 1, #input[2] do
        local s = input[2]:sub(i, i)
        if s == " " then break end

        if #currentStr > 0 and currentStr:sub(1, 1) == "." and s ~= "." then
            table.insert(t, currentStr)
            currentStr = ""
        elseif #currentStr > 0 and currentStr:sub(1, 1) ~= "." and s == "." then
            table.insert(t, currentStr)
            currentStr = ""
        end
        currentStr = currentStr .. s
    end
    return t
end

local function calculatePossibilites(n, s)
    for _, num in ipairs(n) do
        local currentNumber = num
        for k, v in ipairs(s) do
            local checkType = v:sub(1, 1)
            if checkType ~= "." then
                -- do something
                print(k, v, num)
            end
        end
    end
    -- Pdump(n)
    -- Pdump(s)

    if s[1]:sub(1, 1) == "." then
        
    end
end

local function springs()
    local nums = {}
    for num in input[2]:gmatch("(%d+)") do
        table.insert(nums, num)
    end
    local symbols = countSymbols()
    calculatePossibilites(nums, symbols)
    return 0
end

print("What is the sum of those counts?\nAnswer: " .. springs())