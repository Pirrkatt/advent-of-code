require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    return #input == 1 and input[1] or input
end

local function decompressFile(line)
    local decompressedString = ""
    local index = 1

    while index <= #line do
        local start_index, end_index, numChars, repeatCount = string.find(line, "%((%d+)x(%d+)%)", index)
        numChars = tonumber(numChars)
        repeatCount = tonumber(repeatCount)

        if start_index then
            decompressedString = decompressedString .. line:sub(index, start_index - 1)
        else
            decompressedString = decompressedString .. line:sub(index, #line)
            break
        end

        local rep = string.rep(line:sub(end_index + 1, end_index + numChars), repeatCount)
        decompressedString = decompressedString .. rep
        index = end_index + numChars + 1 -- We add (+1) to get the correct index of the next possible match 
    end
    return #decompressedString
end

local function run(input)
    return decompressFile(input)
end

local input = getInput()
local answer = run(input)

print("What is the decompressed length of the file (your puzzle input)? Don't count whitespace.\nAnswer: " .. answer)
