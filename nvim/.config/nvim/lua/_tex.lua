local tex = {}

tex.in_mathzone = function() -- math context detection
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end
tex.in_comment = function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex.in_env = function(name) -- generic environment detection
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex.in_equation = function() -- equation environment detection
	return tex.in_env("equation")
end
tex.in_itemize = function() -- itemize environment detection
	return tex.in_env("itemize")
end
tex.in_tikz = function() -- TikZ picture environment detection
	return tex.in_env("tikzpicture")
end

tex.mbw = function(line_to_cursor, matched_trigger) -- in Mathzone and at line Begin or non_letter (%W)
	local in_mathzone = vim.fn["vimtex#syntax#in_mathzone"]() == 1
	local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
	local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match('[ :`=%{%(%["]')
	return in_mathzone and (line_begin or non_letter)
end

return tex
