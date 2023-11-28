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

function DumpLevel(input, level)
	local indent = ''

	for i = 1, level do
		indent = indent .. '    '
	end

	if type(input) == 'table' then
		local str = '{ \n'
		local lines = {}

		for k, v in pairs(input) do
			if type(k) ~= 'number' then
				k = '"' .. k .. '"'
			end

			if type(v) == 'string' then
				v = '"' .. v .. '"'
			end

			table.insert(lines, indent .. '    [' .. k .. '] = ' .. DumpLevel(v, level + 1))
		end
		return str .. table.concat(lines, ',\n') .. '\n' .. indent .. '}'
	end

	return tostring(input)
end

-- Return a string representation of input for debugging purposes
function Dump(input)
	return DumpLevel(input, 0)
end

-- Call the dump function and print it to console
function Pdump(input)
	local dump_str = Dump(input)
	print(dump_str)
	return dump_str
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

function table.contains(table, value)
	for _, v in pairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

function table.sum(table)
	local sum = 0
	for _, v in ipairs(table) do
		sum = sum + v
	end
	return sum
end