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

-- X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
local values = {
    A = {defeat = "Y", draw = "X", lose = "Z"}, -- Rock
    B = {defeat = "Z", draw = "Y", lose = "X"}, -- Paper
    C = {defeat = "X", draw = "Z", lose = "Y"}, -- Scissors
}

local score = {X = 1, Y = 2, Z = 3}

local winScore = 6
local drawScore = 3

local totalScore = 0

local function calculateOutcome(enemy, outcome)
    local addScore = 0
    if outcome == "Z" then
        addScore = winScore + score[values[enemy].defeat]
    elseif outcome == "Y" then
        addScore = drawScore + score[values[enemy].draw]
    else
        addScore = score[values[enemy].lose]
    end
    return addScore
end

for i = 1, #t.enemy do
    local enemyMove = t.enemy[i]
    local outcome = t.self[i]
    totalScore = totalScore + calculateOutcome(enemyMove, outcome)
end

print("Total Score: " .. totalScore)
