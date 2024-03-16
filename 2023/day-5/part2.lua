require("lib")

local input = GetInput("demo")

-- Figure out which one of the seeds have the lowest location number
-- Keep track of every seed and their respective next type individually

local maps = {
    "seed",
    "soil",
    "fertilizer",
    "water",
    "light",
    "temperature",
    "humidity",
    "location"
}

-- Should modify this function, feels backwards and inefficient right now
local function getContentRows(str)
    str = str:escape()
    local firstRow = -1
    local checkRows = false
    for k, v in ipairs(input) do
        if k == #input then
            return firstRow, k
        end

        if checkRows then
            local containsDigits = v:match("%d+")
            if not containsDigits then
                return firstRow, k - 1
            end
        end

        local found = v:match(str)
        if found then
            firstRow = k + 1
            checkRows = true
        end
    end
    return nil
end

local function getMapString(loop)
    return maps[loop] .. "-to-" .. maps[loop+1] .. " map:"
end

local function fillTables(seedTable, str, currentContent, lastContent)
    local first, last = getContentRows(str)
    local cc = maps[currentContent]
    local lc = maps[lastContent]

    for i = first, last do
        local info = { input[i]:match("(%d+) (%d+) (%d+)") }
        local destStart, srcStart, length = tonumber(info[1]), tonumber(info[2]), tonumber(info[3])

        for index, content in ipairs(seedTable) do
            if content[lc] >= srcStart and content[lc] < srcStart + length then
                local diff = content[lc] - srcStart
                seedTable[index][cc] = destStart + diff
            end

            if i == last then
                if not seedTable[index][cc] then
                    seedTable[index][cc] = seedTable[index][lc]
                end
            end
        end
    end
end

local function getLowestLocation(seedTable)
    local lowest = math.huge
    for i = 1, #seedTable do
        if seedTable[i].location < lowest then
            lowest = seedTable[i].location
        end
    end
    return lowest
end

local function seeds()
    local seedTable = {}

    for seedNumber, length in input[1]:gmatch("(%d+) (%d+)") do
        for i = tonumber(seedNumber), seedNumber + length - 1 do
            table.insert(seedTable, {seed = i})
        end
    end

    for i = 1, #maps-1 do
        fillTables(seedTable, getMapString(i), i+1, i)
    end

    return getLowestLocation(seedTable)
end

print("What is the lowest location number that corresponds to any of the initial seed numbers?\nAnswer: " .. seeds())
