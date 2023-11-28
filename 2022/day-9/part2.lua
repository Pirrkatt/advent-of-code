require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

local rope = {}
local visitedPositions = {"0-0"}
local knotsAmount = 10

local function isTouching(index)
    local tail = rope[index]
    local head = rope[index-1]
    local row = math.abs(head.row - tail.row) <= 1
    local column = math.abs(head.column - tail.column) <= 1
    return row and column
end

local function moveTail(index, last)
    local tail = rope[index]
    local head = rope[index-1]

    if head.row ~= tail.row then -- Move up or down
        tail.row = (head.row > tail.row) and (tail.row + 1) or (tail.row - 1)
    end

    if head.column ~= tail.column then -- Move left or right
        tail.column = (head.column > tail.column) and (tail.column + 1) or (tail.column - 1)
    end

    if last then
        local pos = tail.row .. "-" .. tail.column
        if not table.contains(visitedPositions, pos) then
            table.insert(visitedPositions, pos)
        end
    end
end

local function moveHead(direction, steps)
    local head = rope[1]

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

        for i = 2, #rope do
            if not isTouching(i) then
                moveTail(i, i == #rope)
            end
        end
    end
end

local function ropeBridge()
    for i = 1, knotsAmount do
        table.insert(rope, {row = 0, column = 0})
    end
    for _, v in ipairs(t) do
        local dir = string.match(v, "%u")
        local steps = string.match(v, "%d+")
        moveHead(dir, steps)
    end
    return #visitedPositions
end

print("How many positions does the tail of the rope visit at least once?\nAnswer: " .. ropeBridge())
