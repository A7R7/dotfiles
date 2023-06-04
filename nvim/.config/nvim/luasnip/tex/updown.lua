local tex = require("_tex")
local utils = require("_utils")

return {
	--frac------------------------------------------------------------------------------------

	s(
		{ trig = "dff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dfrac{<>}{<>} ]], { i(1), i(2) }),
		{ condition = tex.in_mathzone and utils.no_letter_before }
	),

	s(
		{ trig = "ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\frac{<>}{<>} ]], { i(1), i(2) }),
		{ condition = tex.in_mathzone and utils.no_letter_before }
	),

	s(
		{ trig = "dd", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dd ]], {}),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "d(%d) ", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dd[<>]{<>} ]], { f(utils.capture1), i(1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "dv ", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dv{<>}{<>} ]], { i(1), i(2) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "dv;", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dv{<>} ]], { i(1) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "d(%d)v;", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dv[<>]{<>} ]], { f(utils.capture1), i(1) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "d(%d)vv", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\dv[<>]{<>}{<>} ]], { f(utils.capture1), i(1), i(2) }),
		{ condition = tex.in_mathzone }
	),

	--binom-----------------------------------------------------------------------------------
	s(
		{ trig = "bin", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\binom{<>}{<>} ]], { i(1), i(2) }),
		{ condition = tex.in_mathzone }
	),

	-- s(
	-- 	{ trig = "dbin", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta([[\dbinom{<>}{<>} ]], { i(1), i(2) }),
	-- 	{ condition = tex.in_mathzone }
	-- ),
	--
	-- s(
	-- 	{ trig = "tbin", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta([[\tbinom{<>}{<>} ]], { i(1), i(2) }),
	-- 	{ condition = tex.in_mathzone }
	-- ),

	--lim-------------------------------------------------------------------------------------
	s(
		{ trig = "lim ", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\lim_{<>} ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "lim(%a)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\lim_{<> \to <>} ]], { f(utils.capture1), f(utils.capture2) }),
		{ condition = tex.in_mathzone }
	),

	-- s(
	-- 	{ trig = "([^%a])lim(%a)pf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta([[<>\lim_{<> \to +\infty} ]], { f(utils.capture1), f(utils.capture2) }),
	-- 	{ condition = tex.in_mathzone }
	-- ),
	--
	-- s(
	-- 	{ trig = "([^%a])lim(%a)nf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta([[<>\lim_{<> \to -\infty} ]], { f(utils.capture1), f(utils.capture2) }),
	-- 	{ condition = tex.in_mathzone }
	-- ),

	s(
		{ trig = "(%a)pf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\lim_{<> \to +\infty} ]], { f(utils.capture1) }),
		{ condition = tex.in_mathzone }
	),

	s(
		{ trig = "(%a)nf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[\lim_{<> \to -\infty} ]], { f(utils.capture1) }),
		{ condition = tex.in_mathzone }
	),

	--log-------------------------------------------------------------------------------------
	s(
		{ trig = "log ", snippetType = "autosnippet" },
		fmta([[\log_{<>}^{<>}]], { i(1), i(2) }),
		{ condition = tex.in_mathzone }
	),
	s({ trig = "ln", snippetType = "autosnippet" }, t([[\ln ]]), { condition = tex.in_mathzone }),
	s({ trig = "lg", snippetType = "autosnippet" }, t([[\lg ]]), { condition = tex.in_mathzone }),
}
