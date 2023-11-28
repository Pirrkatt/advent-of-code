require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")
local str = t[1]
local newStr = ""

local function getPattern() -- Bad code, got lucky? Does not start over from the correct index when failing
    for s in string.gmatch(str, "%w") do
        if not string.match(newStr, s) then
            newStr = newStr .. s
        else
            newStr = ""
        end

        if #newStr == 4 then
            return newStr
        end
    end
end

local function localizePattern()
    local pattern = getPattern()

    local _, stop = string.find(str, pattern)
    return stop
end

print("How many characters need to be processed before the first start-of-packet marker is detected?\nAnswer: " .. localizePattern())
