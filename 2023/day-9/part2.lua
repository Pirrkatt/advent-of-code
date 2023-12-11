require("lib")

local input = GetInput()

local function newSequence(t)
    local sequence = {}
    for i = #t, 1+1, -1 do
        local diff = t[i] - t[i-1]
        table.insert(sequence, 1, diff)
    end
    return sequence
end

local function extrapolateHistory(t)
    table.insert(t[#t], 1, 0)
    for i = #t-1, 1, -1 do
        table.insert(t[i], 1, t[i][1] - t[i+1][1])
    end
end

local function oasis()
    local sum = 0
    for _, v in ipairs(input) do
        local t = {{}}
        for num in v:gmatch("-?%d+") do
            table.insert(t[1], tonumber(num))
        end

        while table.occurrences(t[#t], 0) ~= #t[#t] do
            t[#t+1] = newSequence(t[#t])
        end

        extrapolateHistory(t)
        sum = sum + t[1][1]
    end
    return sum
end

print("What is the sum of these extrapolated values?\nAnswer: " .. oasis())
