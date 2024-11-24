require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    return #input == 1 and input[1] or input
end

local function decompressFile(part, multiplier, index)
    index = index or 1
    local length = 0

    while index <= #part do
        local start_index, end_index, numChars, repeatCount = string.find(part, "%((%d+)x(%d+)%)", index)
        numChars = tonumber(numChars)
        repeatCount = tonumber(repeatCount)

        if not start_index then
            length = length + (#part - index + 1) * (multiplier or 1)
            break
        end

        length = length + (start_index - index) * (multiplier or 1)

        local repeatPart = part:sub(end_index + 1, end_index + numChars)
        local newMultiplier = (multiplier or 1) * tonumber(repeatCount)

        local repeatedLength = decompressFile(repeatPart, newMultiplier)
        length = length + repeatedLength
        index = end_index + numChars + 1
    end
    return length
end

local function run(input)
    return decompressFile(input)
end

local input = getInput()
local answer = run(input)

print("What is the decompressed length of the file using this improved format?\nAnswer: " .. answer)
