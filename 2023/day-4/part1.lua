require("lib")

local fileContent = ReadFile()
local input = GetLines(fileContent, "\r\n")

local function scratchcards()
    local total = {}

    for _, str in ipairs(input) do
        local cardValue = 0

        local winningNumbers = {}
        local winningStr = str:match(": (.+) |")
        for number in winningStr:gmatch("%d+") do
            table.insert(winningNumbers, number)
        end

        local pickedStr = str:match("| (.+)")
        for pickedNumber in pickedStr:gmatch("%d+") do
            if table.contains(winningNumbers, pickedNumber) then
                cardValue = (cardValue > 0 and cardValue * 2) or 1
            end
        end

        table.insert(total, cardValue)
    end

    return table.sum(total)
end

print("How many points are they worth in total?\nAnswer: " .. scratchcards())