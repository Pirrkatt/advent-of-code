require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local function run(input)
    local result = ""
    local characters = {}

    for i = 1, #input[1] do
        for _, line in ipairs(input) do
            table.insert(characters, string.sub(line, i ,i))
        end

        table.sort(characters, function(a, b) return table.occurrences(characters, a) < table.occurrences(characters, b) end)
        result = result .. characters[1]
        characters = {}
    end

    return result
end

local input = getInput()
local answer = run(input)

print("Given the recording in your puzzle input and this new decoding methodology, what is the original message that Santa is trying to send?\nAnswer: " .. answer)