require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

--[[
    Spawn first positions in a table at (newTable = {[1] = 2}) where 1 is row and 2 is column
    Move tail according to head position
    Add visited to a new table with syntax row-column (newTable = {"5-2"})
]]--

-- Initialize starting positions, overlapping
local head = {row = 0, column = 0}
local tail = {row = 0, column = 0}
local visitedPositions = {"0-0"}

local function isTouching()
    local row = math.abs(head.row - tail.row) <= 1
    local column = math.abs(head.column - tail.column) <= 1
    return row and column
end

local function moveTail()
    if head.row ~= tail.row then -- Move up or down
        tail.row = (head.row > tail.row) and (tail.row + 1) or (tail.row - 1)
    end

    if head.column ~= tail.column then -- Move left or right
        tail.column = (head.column > tail.column) and (tail.column + 1) or (tail.column - 1)
    end

    local pos = tail.row .. "-" .. tail.column
    if not table.contains(visitedPositions, pos) then
        table.insert(visitedPositions, pos)
    end
end

local function moveHead(direction, steps)
    for i = 1, steps do
        if direction == "U" then
            head.row = head.row - 1
        elseif direction == "D" then
            head.row = head.row + 1
        elseif direction == "L" then
            head.column = head.column - 1
        elseif direction == "R" then
            head.column = head.column + 1
        end

        if not isTouching() then
            moveTail()
        end
    end
end

local function ropeBridge()
    for _, v in ipairs(t) do
        local dir = string.match(v, "%u")
        local steps = string.match(v, "%d+")
        moveHead(dir, steps)
    end
    return #visitedPositions
end

print("How many positions does the tail of the rope visit at least once?\nAnswer: " .. ropeBridge())