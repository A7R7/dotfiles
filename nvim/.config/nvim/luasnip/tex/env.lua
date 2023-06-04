local tex = require("_tex")
local utils = require("_utils")
local conds = require("luasnip.extras.expand_conditions")
return {

	s(
		{ trig = "env ", snippetType = "autosnippet" },
		fmta(
			[[
    \begin{<>}
      <>
    \end{<>}
    ]],
			{ i(1), i(2), rep(1) }
		),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	s(
		{ trig = "mm ", snippetType = "autosnippet" },
		fmta([[\( <> \)]], { d(1, utils.get_visual) }),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	s(
		{ trig = "Mm ", snippetType = "autosnippet" },
		fmta([[ \(\displaystyle{ <> }\) ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	s(
		{ trig = "MM ", snippetType = "autosnippet" },
		fmta(
			[[
        \[
           <>
        \]
      ]],
			{ d(1, utils.get_visual) }
		),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	-- al ----------------------------------------------------------------------------
	s(
		{ trig = "al ", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{align*}
        <> 
      \end{align*}
      ]],
			{ d(1, utils.get_visual) }
		),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	s(
		{ trig = "MMAL", snippetType = "autosnippet" },
		fmta(
			[[
        \[\begin{aligned}
           <>
        \end{aligned}\]
      ]],
			{ d(1, utils.get_visual) }
		),
		{ condition = tex.in_text and utils.no_letter_before }
	),

	s([[\]], { t({ [[\\]], [[~& ]] }) }, { condition = tex.in_env("align*") }),
	s([[=]], { t({ [[\\]], [[=& ]] }) }, { condition = tex.in_env("align*") }),
	s([[>]], { t({ [[\\]], [[\implies& ]] }) }, { condition = tex.in_env("align*") }),

	-- al ----------------------------------------------------------------------------
	s(
		{ trig = "lc ", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{cases}
        <> 
      \end{cases}
      ]],
			{ d(1, utils.get_visual) }
		),
		{ condition = tex.in_mathzone }
	),

	--text----------------------------------------------------------------------------
	s(
		{ trig = "tt", snippetType = "autosnippet" },
		fmta([[ \text{ <> } ]], { d(1, utils.get_visual) }),
		{ condition = tex.in_mathzone }
	),
}
