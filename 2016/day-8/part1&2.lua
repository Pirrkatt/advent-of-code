require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    return #input == 1 and input[1] or input
end

local function setupScreen(rows, columns)
    local screen = {}
    for row = 1, rows do
        screen[row] = {}
        for column = 1, columns do
            screen[row][column] = "."
        end
    end
    return screen
end

local function createRect(screen, width, height)
    for h = 1, height do
        for w = 1, width do
            screen[h][w] = "#"
        end
    end
    return screen
end

local function rowShift(screen, rowNum, rowPixels)
    local tableCopy = table.copy(screen)

    for i = 1, #tableCopy[rowNum+1] do
        local currentPixel = tableCopy[rowNum+1][i] -- We add 1 because 0 is supposed to be the far left one, but Lua index starts at 1
        local destination = i + rowPixels
        if destination > #tableCopy[rowNum+1] then
            destination = destination%#tableCopy[rowNum+1]
        end
        screen[rowNum+1][destination] = currentPixel
    end
end

local function columnShift(screen, columnNum, columnPixels)
    local tableCopy = table.copy(screen)

    for i = 1, #tableCopy do
        local currentPixel = tableCopy[i][columnNum+1] -- We add 1 because 0 is supposed to be the far left one, but Lua index starts at 1
        local destination = i + columnPixels
        if destination > #tableCopy then
            destination = destination%#tableCopy
        end
        screen[destination][columnNum+1] = currentPixel
    end
end

local function runCommands(input, screen)
    for _, line in pairs(input) do
        local rectWidth, rectHeight = string.match(line, "rect (%d+)x(%d+)")
        local rowNum, rowPixels = string.match(line, "rotate row y=(%d+) by (%d+)")
        local columnNum, columnPixels = string.match(line, "rotate column x=(%d+) by (%d+)")

        if rectWidth and rectHeight then
            createRect(screen, tonumber(rectWidth), tonumber(rectHeight))
        elseif rowNum and rowPixels then
            rowShift(screen, tonumber(rowNum), tonumber(rowPixels))
        elseif columnNum and columnPixels then
            columnShift(screen, tonumber(columnNum), tonumber(columnPixels))
        end
    end
end

local function run(input)
    local screen = setupScreen(6, 50)
    runCommands(input, screen)
    return table.occurrences(screen, "#", true), Pdump(screen, true, true, true)
end

local input = getInput()
local part1, part2 = run(input)

print("There seems to be an intermediate check of the voltage used by the display: after you swipe your card, if the screen did work, how many pixels should be lit?\nAnswer: " .. part1)
print("After you swipe your card, what code is the screen trying to display?\nAnswer: \n" .. part2)
