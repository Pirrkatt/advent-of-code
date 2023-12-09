require("lib")

local input = GetInput()

local function calculateDistance(race)
    local wins = 0
    for i = 1, race.time - 1 do -- 0 and race.time[i] will return 0 distance anyway
        local holdTime = i
        local runTime = race.time - i

        if holdTime * runTime > race.record then
            wins = wins + 1
        end
    end
    return wins
end

local function boatRace()
    local race = {}

    for _, v in ipairs(input) do
        local numberString = ""
        if v:match("Time:") then
            for time in v:gmatch("%d+") do
                numberString = numberString .. time
            end
            race.time = tonumber(numberString)
        elseif v:match("Distance:") then
            for record in v:gmatch("%d+") do
                numberString = numberString .. record
            end
            race.record = tonumber(numberString)
        end
    end

    return calculateDistance(race)
end

print("How many ways can you beat the record in this one much longer race?\nAnswer: " .. boatRace())
