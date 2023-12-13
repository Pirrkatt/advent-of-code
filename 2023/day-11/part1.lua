require("lib")

local input = GetInput()

local function expandUniverse()
    local function checkRows()
        for row = #input, 1, -1 do
            local f = input[row]:find("[^.]")
            if not f then
                table.insert(input, row, input[row])
            end
        end
    end

    local function addColumn(index)
        for row, str in ipairs(input) do
            input[row] = str:sub(1, index) .. "." .. str:sub(index+1, #str)
        end
    end

    local function checkColumns()
        for x = #input[1], 1, -1 do -- Loop horizontal
            local valid = true
            for y = 1, #input do -- Loop vertical
                if input[y]:sub(x, x) ~= "." then
                    valid = false
                    break
                end
            end
            if valid then
                addColumn(x)
            end
        end
    end

    checkColumns()
    checkRows()
end

local function assignGalaxyNumbers()
    local t = {}
    local num = 0
    for _, v in ipairs(input) do
        local line = v:gsub("#", function() num = num + 1 return num end)
        table.insert(t, line)
    end
    input = t
end

local function shortestPaths(index, row)
    local t = {}
    for y = row, #input do
        local i = y == row and index + 1 or 1
        local galaxyFound = input[y]:find("#", i)

        while galaxyFound do
            local gx, gy = galaxyFound, y
            table.insert(t, math.abs(row-gy) + math.abs(index-gx))
            i = galaxyFound + 1
            galaxyFound = input[y]:find("#", i)
        end
    end
    return #t > 0 and t or nil
end

local function universe()
    expandUniverse()
    -- assignGalaxyNumbers()

    local paths = {}
    for k, v in ipairs(input) do
        local i = 1
        local galaxyFound = v:find("#", i)

        while galaxyFound do
            table.insert(paths, shortestPaths(galaxyFound, k))
            i = galaxyFound + 1
            galaxyFound = v:find("#", i)
        end
    end

    local sum = 0
    for _, v in ipairs(paths) do
        sum = sum + table.sum(v)
    end
    return sum
end

print("What is the sum of these lengths?\nAnswer: " .. universe())
