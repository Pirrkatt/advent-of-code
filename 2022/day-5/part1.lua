require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")

local function getStackLine()
    for k, v in pairs(t) do
        if string.find(v, "%d+") then
            return k
        end
    end
end

local function getStackTable(index)
    local line = getStackLine()
    local stack = string.match(t[line], "%d+", index)
    return tonumber(stack)
end

local stacks = {}
local function setupTable()
    for i = getStackLine() - 1, 1, -1 do
        local index
        for str in string.gmatch(t[i], "([A-Z])") do
            index = string.find(t[i], str, index == nil and 0 or index + 1)
            local stack = getStackTable(index)

            if not stacks[stack] then
                stacks[stack] = {}
            end
            table.insert(stacks[stack], str)
        end
    end
end

local function rearrangeTable()
    for _, v in pairs(t) do
        local move = string.match(v, "move ([%d]+)")
        local from = string.match(v, "from ([%d]+)")
        local to = string.match(v, "to ([%d]+)")
        move, from, to = tonumber(move), tonumber(from), tonumber(to)
        if move then
            for i = 1, move do
                local value = stacks[from][#stacks[from]]
                table.remove(stacks[from], #stacks[from])
                table.insert(stacks[to], value)
            end
        end
    end
end

local function getResult()
    local result = ""
    for k,_ in pairs(stacks) do
        result = result .. stacks[k][#stacks[k]]
    end
    return result
end

setupTable()
rearrangeTable()
local topCrates = getResult()

print("After the rearrangement procedure completes, what crate ends up on top of each stack?\nAnswer: " .. topCrates)
