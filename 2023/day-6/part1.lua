require("lib")

local input = GetInput()

local function calculateDistance(race)
    local multipliedWins = 1
    for i = 1, #race.time do
        local wins = 0
        for j = 1, race.time[i] - 1 do -- 0 and race.time[i] will return 0 distance anyway
            local holdTime = j
            local runTime = race.time[i] - j

            if holdTime * runTime > race.record[i] then
                wins = wins + 1
            end
        end
        multipliedWins = multipliedWins * wins
    end
    return multipliedWins
end

local function boatRace()
    local race = {
        time = {},
        record = {}
    }

    for _, v in ipairs(input) do
        if v:match("Time:") then
            for time in v:gmatch("%d+") do
                table.insert(race.time, tonumber(time))
            end
        elseif v:match("Distance:") then
            for record in v:gmatch("%d+") do
                table.insert(race.record, tonumber(record))
            end
        end
    end

    return calculateDistance(race)
end

print("What do you get if you multiply these numbers together?\nAnswer: " .. boatRace())
