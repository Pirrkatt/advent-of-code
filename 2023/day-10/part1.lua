require("lib")

local input = GetInput()

--[[
|   is a vertical pipe connecting north and south.
-   is a horizontal pipe connecting east and west.
L   is a 90-degree bend connecting north and east.
J   is a 90-degree bend connecting north and west.
7   is a 90-degree bend connecting south and west.
F   is a 90-degree bend connecting south and east.
.   is ground; there is no pipe in this tile.
S   is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
]]--

-- Find starting position
-- Find the two starting pipes accordingly from starting position
-- Loop twice from starting position until both loops are at the same coordinate
-- Count the steps

local pipeSymbols = {
    ["north"] = {"|", "L", "J"},
    ["east"] = {"-", "L", "F"},
    ["south"] = {"|", "7", "F"},
    ["west"] = {"-", "J", "7"}
}

local function findStartPipes(x, y)
    local maxRight = math.min(x+1, #input[y])
    local maxLeft = math.max(x-1, 1)

    local north = input[math.max(y-1, 1)]:sub(x, x)
    local south = input[math.min(y+1, #input)]:sub(x, x)
    local east = input[y]:sub(maxRight, maxRight)
    local west = input[y]:sub(maxLeft, maxLeft)

    local t = {}
    if north and table.contains(pipeSymbols.south, north) then
        t[#t+1] = {currentPos = {x = x, y = y-1}, lastPos = {x = x, y = y}}
    end
    if east and table.contains(pipeSymbols.west, east) then
        t[#t+1] = {currentPos = {x = x+1, y = y}, lastPos = {x = x, y = y}}
    end
    if south and table.contains(pipeSymbols.north, south) then
        t[#t+1] = {currentPos = {x = x, y = y+1}, lastPos = {x = x, y = y}}
    end
    if west and table.contains(pipeSymbols.east, west) then
        t[#t+1] = {currentPos = {x = x-1, y = y}, lastPos = {x = x, y = y}}
    end
    return t
end

local function checkDirection(path, symbol, dir, x, y)
    local oppositeDir = {["north"] = "south", ["south"] = "north", ["east"] = "west", ["west"] = "east"}
    local currentSymbol = input[path.currentPos.y]:sub(path.currentPos.x, path.currentPos.x)
    local newX, newY = path.currentPos.x + x, path.currentPos.y + y
    if (x ~= 0 and path.lastPos.x ~= newX) or (y ~= 0 and path.lastPos.y ~= newY) then
        if table.contains(pipeSymbols[dir], currentSymbol) then
            if symbol and table.contains(pipeSymbols[oppositeDir[dir]], symbol) then
                return {currentPos = {x = newX, y = newY}, lastPos = {x = path.currentPos.x, y = path.currentPos.y}}
            end
        end
    end
    return nil
end

local function runPipes(path)
    local x, y = path.currentPos.x, path.currentPos.y

    local maxRight = math.min(x+1, #input[y])
    local maxLeft = math.max(x-1, 1)

    local north = input[math.max(y-1, 1)]:sub(x, x)
    local south = input[math.min(y+1, #input)]:sub(x, x)
    local east = input[y]:sub(maxRight, maxRight)
    local west = input[y]:sub(maxLeft, maxLeft)

    return checkDirection(path, north, "north", 0, -1) or
        checkDirection(path, east, "east", 1, 0) or
        checkDirection(path, south, "south", 0, 1) or
        checkDirection(path, west, "west", -1, 0)
end

local function pipesTouching(pathsTable)
    if pathsTable[1].currentPos.x == pathsTable[2].currentPos.x and
    pathsTable[1].currentPos.y == pathsTable[2].currentPos.y then
        return true
    end
    return false
end

local function pipes()
    local sum = 1 -- Start at 1 because finding start pipes doesn't include a +1
    local paths

    for row, str in ipairs(input) do
        local start = str:find("S")
        if start then
            paths = findStartPipes(start, row)
        end
    end

    while not pipesTouching(paths) do
        sum = sum + 1
        for i = 1, #paths do
            paths[i] = runPipes(paths[i])
        end
    end
    return sum
end

print("How many steps along the loop does it take to get from the starting position to the point farthest from the starting position?\nAnswer: " .. pipes())
