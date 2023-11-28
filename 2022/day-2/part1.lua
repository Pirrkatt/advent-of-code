require("lib")

local foundEnemy = false
local function getLines(input)
    local t = {enemy = {}, self = {}}
    for str in string.gmatch(input, "([A-Z])") do
        if not foundEnemy then
            table.insert(t.enemy, str)
            foundEnemy = true
        else
            table.insert(t.self, str)
            foundEnemy = false
        end
    end
    return t
end

local fileContent = ReadFile()
local t = getLines(fileContent)

local values = {
    X = {defeat = "C", draw = "A", score = 1}, -- Rock
    Y = {defeat = "A", draw = "B", score = 2}, -- Paper
    Z = {defeat = "B", draw = "C", score = 3}, -- Scissors
}

local winScore = 6
local drawScore = 3

local totalScore = 0
for i = 1, #t.enemy do
    local addScore = 0
    local selfMove = values[t.self[i]]
    local enemyMove = t.enemy[i]

    if selfMove.defeat == enemyMove then
        addScore = winScore + selfMove.score
    elseif selfMove.draw == enemyMove then
        addScore = drawScore + selfMove.score
    else
        addScore = selfMove.score
    end
    totalScore = totalScore + addScore
end

print("Total Score: " .. totalScore)
