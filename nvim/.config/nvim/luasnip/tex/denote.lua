package.path = "./_tex.lua;" .. package.path
local utils = require("_utils")
local tex = require("_tex")

return {

	s({ trig = "big", snippetType = "autosnippet" }, fmta([[\big]], {}), { condition = tex.in_mathzone }),
	-- power-----------------------------------------------------------------------------------

	s(
		{ trig = "ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[e^{<>} ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	--sub-----------------------------------------------------------------------------------
	s(
		{ trig = ";;", snippetType = "autosnippet", wordTrig = false },
		fmta([[_{<>}]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "(%a);(%w)", snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[<>_<>]], { f(utils.capture1), f(utils.capture2) }),
		{ condition = tex.in_mathzone }
	),

	--sup-----------------------------------------------------------------------------------
	s(
		{ trig = [['']], snippetType = "autosnippet", wordTrig = false },
		fmta([[^{<>}]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = [['(%w)]], snippetType = "autosnippet", regTrig = true, wordTrig = false },
		fmta([[^<>]], { f(utils.capture1) }),
		{ condition = tex.in_mathzone }
	),
}
