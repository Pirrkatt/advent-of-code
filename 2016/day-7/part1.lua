require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local function checkABBA(str)
    local sequence = {}
    for i = 1, #str do
        table.insert(sequence, string.sub(str, i, i))
    end

    for i = 1, #sequence do
        if sequence[i] == sequence[i+3] and
            sequence[i+1] == sequence[i+2] and
            sequence[i] ~= sequence[i+1] then
            return true
        end
    end
    return false
end

local function supportsTLS(str)
    for hypernet in string.gmatch(str, "%[(%l+)%]") do
        if checkABBA(hypernet) then
            return false
        end
    end

    -- Now, check non-hypernet sequences (outside square brackets)
    local outsideBrackets = str
    for hyper in string.gmatch(str, "%[%l+%]") do
        hyper = hyper:sub(2, #hyper - 1)
        outsideBrackets = outsideBrackets:gsub("%[" .. hyper .. "%]", " ")
    end

    -- After removing hypernet sequences, check remaining segments
    for segment in string.gmatch(outsideBrackets, "%l+") do
        if checkABBA(segment) then
            return true
        end
    end
    return false
end

local function run(input)
    local result = 0
    for _, line in ipairs(input) do
        if supportsTLS(line) then
            result = result + 1
        end
    end

    return result
end

local input = getInput()
local answer = run(input)

print("How many IPs in your puzzle input support TLS?\nAnswer: " .. answer)