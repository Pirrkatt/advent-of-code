require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\r\n")

local x_register = 1
local totalCycles = 0

local CRT = ""
local spritePosition = "###....................................."

local function updateSpritePosition()
    spritePosition = ""
    for i = 0, 39 do -- positions 0-39 to match example
        if math.abs(i - x_register) <= 1 then
            spritePosition = spritePosition .. "#"
        else
            spritePosition = spritePosition .. "."
        end
    end
end

local function drawPixel()
    for i = 1, 6 do
        if totalCycles == 40 * i then
            CRT = CRT .. "\n"
        end
    end
    local sprite = string.sub(spritePosition, totalCycles%40 + 1, totalCycles%40 + 1)
    CRT = CRT .. sprite
end

local function runCycles()
    for _, v in pairs(t) do
        local noop = string.match(v, "noop")
        local add = string.match(v, "addx (-?%d+)")

        if noop then
            drawPixel()
            totalCycles = totalCycles + 1
        else
            for i = 1, 2 do -- addx takes 2 cycles to complete
                drawPixel()
                totalCycles = totalCycles + 1
            end
            x_register = x_register + add
            updateSpritePosition()
        end
    end
    return CRT
end

print("What eight capital letters appear on your CRT?\nAnswer:\n" .. runCycles())
