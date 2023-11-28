require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")

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
            table.insert(currentDirectory, subTable)

            for _,d in pairs(directories) do
                table.insert(sumTable[d], tonumber(size))
            end
        end
    end
end

local function addTableValues()
    setupFilesystem()

    local totalSpace = 70000000
    local neededSpace = 30000000
    local sizes = {}
    for _, v in pairs(sumTable) do
        local size = 0
        for _, z in pairs(v) do
            size = size + z
        end
        table.insert(sizes, size)
    end
    local unusedSpace = totalSpace - math.max(table.unpack(sizes))
    neededSpace = neededSpace - unusedSpace -- Minimum size the directory needs to have

    local currentMinimum = 0
    for _, size in pairs(sizes) do
        if currentMinimum == 0 then
            currentMinimum = size
        end
        if size >= neededSpace and size < currentMinimum then
            currentMinimum = size
        end
    end
    return currentMinimum
end

print("What is the total size of that directory?\nAnswer: " .. addTableValues())
