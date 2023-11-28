require("lib")

local fileContent = ReadFile()
local t = GetLines(fileContent, "\n")
local str = t[1]
local newStr = ""

local function getPattern()
    for i = 1, #str do
        for s in string.gmatch(str, "%w", i) do
            if not string.match(newStr, s) then
                newStr = newStr .. s
            else
                newStr = ""
                break
            end

            if #newStr == 14 then
                return newStr
            end
        end
    end
end

local function localizePattern()
    local pattern = getPattern()

    local _, stop = string.find(str, pattern)
    return stop
end

print("How many characters need to be processed before the first start-of-message marker is detected?\nAnswer: " .. localizePattern())
