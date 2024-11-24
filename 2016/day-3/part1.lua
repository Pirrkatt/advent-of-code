require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local function checkTriangle(triangle)
    local a, b, c = string.match(triangle, "(%d+)%s+(%d+)%s+(%d+)")
    a, b, c = tonumber(a), tonumber(b), tonumber(c)
    return (a + b > c) and (b + c > a) and (a + c > b)
end

local function run(input)
    local possibilities = 0
    for _, line in ipairs(input) do
        if checkTriangle(line) then
            possibilities = possibilities + 1
        end
    end
    return possibilities
end

local input = getInput()
local answer = run(input)

print("In your puzzle input, how many of the listed triangles are possible?\nAnswer: " .. answer)