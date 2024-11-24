require("lib")

local function getInput(demo)
    local input = GetInput(demo)
    if #input == 1 then
        input = input[1]
    end
    return input
end

local function checkTriangle(a, b, c)
    a, b, c = tonumber(a), tonumber(b), tonumber(c)
    return (a + b > c) and (b + c > a) and (a + c > b)
end

local function run(input)
    local possibilities = 0
    local lines = {}

    for _, line in ipairs(input) do
        local a, b, c = string.match(line, "(%d+)%s+(%d+)%s+(%d+)")
        table.insert(lines, {a, b, c})
    end

    for i = 1, #lines, 3 do
        if lines[i+2] then
            local column1 = {lines[i][1], lines[i+1][1], lines[i+2][1]}
            local column2 = {lines[i][2], lines[i+1][2], lines[i+2][2]}
            local column3 = {lines[i][3], lines[i+1][3], lines[i+2][3]}

            if checkTriangle(column1[1], column1[2], column1[3]) then
                possibilities = possibilities + 1
            end
            if checkTriangle(column2[1], column2[2], column2[3]) then
                possibilities = possibilities + 1
            end
            if checkTriangle(column3[1], column3[2], column3[3]) then
                possibilities = possibilities + 1
            end
        end
    end
    return possibilities
end

local input = getInput()
local answer = run(input)

print("In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?\nAnswer: " .. answer)