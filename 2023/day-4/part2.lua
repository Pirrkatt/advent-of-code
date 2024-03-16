-- Bugged, runs slow sometimes
require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")
local totalCards = {}

local function newInstance(matches, row)
    row = row + 1 -- To start from 1 row below the current winning row
    for i = row, row + matches - 1 do
        if i > #input then
            return
        end

        CheckMatches(i, input[i])
    end
end

function CheckMatches(row, str)
    local matches = 0

    local winningNumbers = {}
    local winningStr = str:match(": (.+) |")
    for number in winningStr:gmatch("%d+") do
        table.insert(winningNumbers, number)
    end

    local pickedStr = str:match("| (.+)")
    for pickedNumber in pickedStr:gmatch("%d+") do
        if table.contains(winningNumbers, pickedNumber) then
            matches = matches + 1
        end
    end

    totalCards[row] = (totalCards[row] or 0) + 1
    newInstance(matches, row)
end

local function scratchcards()
    for row, str in ipairs(input) do
        CheckMatches(row, str)
    end

    return table.sum(totalCards)
end

print("How many total scratchcards do you end up with?\nAnswer: " .. scratchcards())
