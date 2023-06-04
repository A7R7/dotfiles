local utils = require('_utils')
local tex = require('_tex')

return {

s({trig = 'tbf', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\textbf{<>}]],
  { i(1) }),
  {condition = tex.in_text}
),
s({trig = 'mbf', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\mathbf{<>}]],
  { i(1) }),
  {condition = tex.in_mathzone}
),
s({trig = 'mtb', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\mathtb{<>}]],
  { i(1) }),
  {condition = tex.in_mathzone}
),
s({trig = 'mca', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\mathcal{<>}]],
  { i(1) }),
  {condition = tex.in_mathzone}
),
s({trig = 'mbb', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\mathbb{<>}]],
  { i(1) }),
  {condition = tex.in_mathzone}
),
}
