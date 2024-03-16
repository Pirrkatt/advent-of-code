require("lib")

local input = GetInput()

-- Loop one direction at a time
-- Remember the last line number

local function getLine(letters)
    for line, str in ipairs(input) do
        if str:match(letters .. " = ") then
            return line
        end
    end
    return nil
end

local function getLetters(dir, line)
    local left, right = input[line]:match("%((%u+), (%u+)%)")
    return dir == "R" and right or left
end

local function hauntedWasteland(s, l)
    local steps = s or 0
    local currentLetters = l or "AAA"

    for direction in input[1]:gmatch("%u") do
        local currentLine = getLine(currentLetters)
        currentLetters = getLetters(direction, currentLine)
        steps = steps + 1

        if currentLetters == "ZZZ" then
            break
        end
    end

    if currentLetters ~= "ZZZ" then
        return hauntedWasteland(steps, currentLetters)
    end
    return steps
end

print("How many steps are required to reach ZZZ?\nAnswer: " .. hauntedWasteland())
