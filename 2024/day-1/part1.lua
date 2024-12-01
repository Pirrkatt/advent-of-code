require("lib")

local input = GetInput()

local function getTotalDistance()
    local result = 0
    local leftList, rightList = {}, {}

    for _, str in ipairs(input) do
        local firstValue, secondValue = str:match("^(%d+)%s+(%d+)$")
        table.insert(leftList, tonumber(firstValue))
        table.insert(rightList, tonumber(secondValue))
    end

    table.sort(leftList)
    table.sort(rightList)

    for i = 1, #leftList do
        result = result + math.abs(leftList[i] - rightList[i])
    end

    return result
end

print("What is the total distance between your lists?\nAnswer: " .. getTotalDistance())