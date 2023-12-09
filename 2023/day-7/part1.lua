---@diagnostic disable: cast-local-type
require("lib")

local input = GetInput()

-- Use table.sort to sort the input table in order using a custom function
-- Rank each hand in the order of strength compared to all other hands
-- Multiply rank by bid amount

-- 5 Same
-- 4 Same + 1
-- 3 Same + 2 same
-- 3 Same + 2 different
-- 2 Pair + 1 different
-- 1 Pair + 3 different
-- Highest card (all cards are different)

-- Correct order:
-- 32T3K
-- KTJJT
-- KK677
-- T55J5
-- QQQJA

local cardValue = {"A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}
local cardAmount = 5

local function getCardValues(hand)
    local foundChars = {}
    local t = {}
    for i = 1, #hand do
        if not table.contains(foundChars, hand[i]) then
            table.insert(t, table.occurrences(hand, hand[i]))
            table.insert(foundChars, hand[i])
        end
    end
    return t
end

local function getHandScore(hand)
    if table.contains(hand, 5) then
        return 5
    elseif table.contains(hand, 4) then
        return 4
    elseif table.contains(hand, 3) then
        if table.contains(hand, 2) then
            return 3.5
        else
            return 3
        end
    elseif table.contains(hand, 2) then
        if table.occurrences(hand, 2) >= 2 then
            return 2.5
        else
            return 2
        end
    end
    return 1
end

local function secondSortRule(a, b)
    local aScore, bScore = 0, 0
    for i = 1, cardAmount do
        local cardA, cardB = a:sub(i, i), b:sub(i, i)
        if cardA ~= cardB then
            aScore = table.getKey(cardValue, cardA)
            bScore = table.getKey(cardValue, cardB)
            break
        end
    end
    return aScore > bScore
end

local function sortHands(a, b)
    a, b = a:gsub(" %d+", ""), b:gsub(" %d+", "")

    local handA, handB = {}, {}
    for i = 1, cardAmount do
        local cardA, cardB = a:sub(i, i), b:sub(i, i)
        table.insert(handA, cardA)
        table.insert(handB, cardB)
    end

    local handValueA, handValueB = getCardValues(handA), getCardValues(handB)
    local aScore, bScore = getHandScore(handValueA), getHandScore(handValueB)

    if aScore == bScore then
        return secondSortRule(a, b)
    end
    return aScore < bScore
end

local function camelCards()
    table.sort(input, function(a, b) return sortHands(a, b) end)

    local totalWinnings = 0
    for i = 1, #input do
        local bid = input[i]:match(" (%d+)")
        totalWinnings = totalWinnings + (bid * i)
    end
    return totalWinnings
end

print("What are the total winnings?\nAnswer: " .. camelCards())
