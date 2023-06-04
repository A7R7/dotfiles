local tex = require("_tex")
local utils = require("_utils")

return {
	--sqrt------------------------------------------------------------------------------------
	s(
		{ trig = "sq", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\sqrt{<>} ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ab", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[|<>| ]], {  d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	--par-------------------------------------------------------------------------------------
	s(
		{ trig = "par", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\par{ <> } ]], {d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "set", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\set{ <> }) ]], {d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	--hat----------------------------------------------------------------------------------------
	s(
		{ trig = "ht", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\hat{<>} ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ba", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\bar{<>} ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ol", snippetType = "autosnippet" },
		fmta([[\overline{<>}]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "ul", snippetType = "autosnippet" },
		fmta([[\underline{<>}]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),
}
