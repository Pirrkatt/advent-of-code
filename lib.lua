function GetInput(demo)
    local info = debug.getinfo(2, "S")
    local path = info.source:match("Advent of Code\\(.*)part")
    path = demo == "demo" and (path .. "demo-input.txt") or (path .. "input.txt")

    local file, errorMsg = io.open(path, "r")
    if not file then
        error("\n-- ERROR: Unable to open file - " .. errorMsg)
    end

	local lines = {}
    for line in file:lines() do
		table.insert(lines, line)
	end

    file:close()
    return lines
end

-- Keep function for backward compatibility
function ReadFile(demo)
    local info = debug.getinfo(2, "S")
    local path = info.source:match("Advent of Code\\(.*)part")
    path = demo == "demo" and (path .. "demo-input.txt") or (path .. "input.txt")

    local file = io.open(path, "rb")
    if not file then return nil end

    local content = file:read "*a"
    file:close()
    return content
end

-- Keep function for backward compatibility
function GetLines(input, sep)
    if sep == nil then
        sep = "%s"
    end

    local t = {}
    for str in string.gmatch(input, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function Pdump(t, compact, hideKeys, hideQuotes)
    hideKeys = hideKeys or false
    hideQuotes = hideQuotes or false
    local indent = 4
    local toPrint = {}

    if compact then
        local function formatCompact(t)
            local result = "{"

            -- Loop through the table
            for k, v in pairs(t) do
                -- Handle the case for tables inside tables (nested tables)
                if type(v) == "table" then
                    result = result .. string.rep(" ", indent) .. "[" .. tostring(k) .. "] = {" .. formatCompact(v) .. ",\n"
                else
                    -- Add simple key-value pairs
                    if not hideKeys then
                        result = result .. "[" .. tostring(k) .. "] = "
                    end
                    if not hideQuotes then
                        result = result .. '"'
                    end
    
                    result = result .. tostring(v)

                    if not hideQuotes then
                        result = result .. '"'
                    end
                    if k ~= #t then
                        result = result .. ', '
                    end
                end
            end

            return result .. "}"
        end

        -- Print the table in compact format
        table.insert(toPrint, formatCompact(t))
    end

    if not compact then
        local function formatExpanded(t, level)
            local result = "{\n"

            local currentIndent = string.rep(" ", level * indent)

            for k, v in pairs(t) do
                if type(v) == "table" then
                    result = result .. currentIndent .. "[" .. tostring(k) .. "] = {\n" .. formatExpanded(v, level + 1) .. "},\n"
                else
                    result = result .. currentIndent .. "[" .. tostring(k) .. "] = " .. '"' .. tostring(v) .. '",\n'
                end
            end

            return result .. "}"
        end

        table.insert(toPrint, formatExpanded(t, 1))
    end

    local result = table.concat(toPrint, "\n")
    print(result)
    return result
end

function DeepSearch(table, targetValue)
    for key, value in pairs(table) do
        if value == targetValue then
            return key
        elseif type(value) == "table" then
            local result = DeepSearch(value, targetValue)
            if result then
                return key .. "." .. result
            end
        end
    end
    return nil
end

local function tablesEqual(tbl1, tbl2)
    if type(tbl1) ~= "table" or type(tbl2) ~= "table" then
        return false
    end
    if #tbl1 ~= #tbl2 then
        return false
    end
    for i = 1, #tbl1 do
        if tbl1[i] ~= tbl2[i] then
            return false
        end
    end
    return true
end

function table.contains(table, value)
	for _, v in pairs(table) do
		if type(v) == "table" and type(value) == "table" then
			if tablesEqual(v, value) then
				return true
			end
		elseif v == value then
			return true
		end
	end
	return false
end

function table.occurrences(t, value, recursive)
    local occurrences = 0
    for _, v in pairs(t) do
        if type(v) == 'table' and recursive then
            occurrences = occurrences + table.occurrences(v, value, recursive)
        else
            if v == value then
                occurrences = occurrences + 1
            end
        end
    end
    return occurrences
end

function table.getKey(table, value)
	for k, v in pairs(table) do
		if v == value then
			return k
		end
	end
	return nil
end

function table.sum(t, recursive)
    local sum = 0
    for _, v in ipairs(t) do
        if type(v) == 'table' and recursive then
            sum = sum + table.sum(v, true) -- Recursively sum inner tables
        else
            sum = sum + v -- Add the value if it's not a table
        end
    end
    return sum
end

function table.copy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[table.copy(orig_key, copies)] = table.copy(orig_value, copies)
            end
            setmetatable(copy, table.copy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function string.escape(str, startIndex)
    local pattern = "[%%%.%(%)%+%-%*%?%[%]%^%$]"
    local index = startIndex or 1
    local s = str:match(pattern, index)
    if s then
        local position = str:find(pattern, index)
        local modifiedString = str:sub(1, position - 1) .. "%" .. str:sub(position, #str)
        return string.escape(modifiedString, position + 2)
    end
    return str
end