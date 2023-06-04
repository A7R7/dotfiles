local M = {}

-- Be sure to explicitly define these LuaSnip node abbreviations!
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.get_visual(_, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1, ""))
	end
end

function M.no_letter_before(line_to_cursor, matched_trigger)
	local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
	local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
	return line_begin or non_letter
end

function M.capture1(_, snip)
	return snip.captures[1]
end
function M.capture2(_, snip)
	return snip.captures[2]
end
function M.capture3(_, snip)
	return snip.captures[3]
end
function M.capture4(_, snip)
	return snip.captures[4]
end

return M
