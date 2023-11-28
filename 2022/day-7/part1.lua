require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")

-- / = outermost directory
-- $ = executed commands
-- cd = change directory
-- ls = list
-- 123 abc = [size] [name]
-- dir xyz = directory named xyz
-- The total size of a directory is the sum of the sizes of the files it contains, directly or indirectly.

-- idea:
--[[
["/"] = {
    ["a"] = {
        [1] = {name = name, size = size},
        ["e"] = {
            [1] = {name = name, size = size}
        }
    }
    ["d"] = {
        [1] = {name = name, size = size}
    }
}
]]--

local directories = {"root1"}

local function getDirectory()
    local fs = {}
    for _, dir in ipairs(directories) do
        if not fs[dir] then
            fs[dir] = {}
        end
        fs = fs[dir]
    end
    return fs
end

local sumTable = {}
sumTable["root1"] = {}

local function setupFilesystem()
    local currentDirectory = getDirectory()
    for k, v in pairs(t) do
        local dir = string.match(v, "dir (%w+)")
        local back = string.match(v, "$ cd %.%.")
        local cd = string.match(v, "$ cd (%w+)")
        local size, name = string.match(v, "(%d+) (%S+)")

        if dir then
            if not currentDirectory[dir] then
                currentDirectory[dir] = {}
            end
        elseif back then
            table.remove(directories)
            currentDirectory = getDirectory()
        elseif cd then
            if not sumTable[cd .. k] then
                sumTable[cd .. k] = {}
            end
            table.insert(directories, cd .. k)
            currentDirectory = getDirectory()
        elseif size and name then
            local subTable = {}
            subTable.size = size
            subTable.name = name
            table.insert(currentDirectory, subTable) -- This only sets up filesystem?

            for _,d in pairs(directories) do
                table.insert(sumTable[d], tonumber(size)) -- Insert size to every subfolder of currentDirectory
            end
        end
    end
end

local function addTableValues()
    setupFilesystem()

    local totalSum = 0
    for _, v in pairs(sumTable) do
        local size = 0
        for _, z in pairs(v) do
            size = size + z
            if size > 100000 then
                size = 0
                break
            end
        end
        totalSum = totalSum + size
    end
    return totalSum
end

print("What is the sum of the total sizes of those directories?\nAnswer: " .. addTableValues())

-- Took pretty long, did not take into consideration of non-unique folder names
-- Solved by adding line number (k) after folder names (cd)