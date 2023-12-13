require("lib")

local input = GetInput()

-- Figure out where there are empty lines that should be expanded
-- Check if the paths cross those lines and multiply by 1 million

local function expandUniverse()
    local c, r = {}, {}
    local function checkRows()
        for y = 1, #input do
            local x = input[y]:find("[^.]")
            if not x then
                table.insert(r, y)
            end
        end
    end

    local function checkColumns()
        for x = 1, #input[1] do -- Loop horizontal
            local valid = true
            for y = 1, #input do -- Loop vertical
                if input[y]:sub(x, x) ~= "." then
                    valid = false
                    break
                end
            end
            if valid then
                table.insert(c, x)
            end
        end
    end

    checkColumns()
    checkRows()
    return c, r
end

local function checkCrossingExpanded(c, r, x1, y1, x2, y2)
    local added = 0
    local add = 1000000-1
    local dx,dy = x2-x1, y2-y1
    if dx < 0 then
        for i = x1, x1+dx, -1 do
            if table.contains(c, i) then
                added = added + add
            end
        end
    else
        for i = x1, x1+dx do
            if table.contains(c, i) then
                added = added + add
            end
        end
    end

    if dy < 0 then
        for j = y1, y1+dy, -1 do
            if table.contains(r, j) then
                added = added + add
            end
        end
    else
        for j = y1, y1+dy do
            if table.contains(r, j) then
                added = added + add
            end
        end
    end
    return added
end

local function shortestPaths(index, row, c, r)
    local sum = 0
    for y = row, #input do
        local i = y == row and index + 1 or 1
        local galaxyFound = input[y]:find("#", i)

        while galaxyFound do
            local gx, gy = galaxyFound, y
            local add = checkCrossingExpanded(c, r, index, row, gx, gy)
            sum = sum + (math.abs(row-gy) + math.abs(index-gx) + add)
            i = galaxyFound + 1
            galaxyFound = input[y]:find("#", i)
        end
    end
    return sum
end

local function universe()
    local c, r = expandUniverse()

    local sum = 0
    for k, v in ipairs(input) do
        local i = 1
        local galaxyFound = v:find("#", i)

        while galaxyFound do
            sum = sum + shortestPaths(galaxyFound, k, c, r)
            i = galaxyFound + 1
            galaxyFound = v:find("#", i)
        end
    end
    return sum
end

print("What is the sum of these lengths?\nAnswer: " .. universe())
