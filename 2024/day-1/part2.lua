require("lib")

local input = GetInput()

local function getSimilarity()
    local result = 0
    local leftList, rightList = {}, {}
    local similarityCache = {}

    for _, str in ipairs(input) do
        local firstValue, secondValue = str:match("^(%d+)%s+(%d+)$")
        table.insert(leftList, tonumber(firstValue))
        table.insert(rightList, tonumber(secondValue))
    end

    for _, num in ipairs(leftList) do
        if not similarityCache[num] then
            similarityCache[num] = table.occurrences(rightList, num)
        end

        result = result + (num * similarityCache[num])
    end

    return result
end

print("What is their similarity score?\nAnswer: " .. getSimilarity())