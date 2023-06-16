local tex = require("_tex")
local utils = require("_utils")
local mbw = tex.in_mathzone and utils.line_begin_or_non_letter
return {

	s(
		{ trig = "pr", snippetType = "autosnippet" },
		fmta([[\mathbf{Pr}( <> )]], { i(1) }),
		{ condition = tex.in_mathzone }
	),
	-- s(
	-- 	{ trig = "exp", snippetType = "autosnippet" },
	-- 	fmta([=[\mathbf{E}[ <> ]]=], { i(1) }),
	-- 	{ condition = tex.in_mathzone }
	-- ),
	s({ trig = "real", snippetType = "autosnippet" }, { t([[\mathbb{R} ]]) }, { condition = tex.in_mathzone }),
	s({ trig = "sigf", snippetType = "autosnippet" }, { t([[\mathcal{F} ]]) }, { condition = tex.in_mathzone }),
	s(
		{ trig = "var", snippetType = "autosnippet" },
		fmta([=[\mathbf{Var}[ <> ]]=], { i(1) }),
		{ condition = tex.in_mathzone }
	),
	s(
		{ trig = "cov", snippetType = "autosnippet" },
		fmta([[\mathbf{Cov}( <> )]], { i(1) }),
		{ condition = tex.in_mathzone }
	),
}
