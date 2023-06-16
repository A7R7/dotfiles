local tex = require('_tex')
local utils = require('_utils')

return {

--int-------------------------------------------------------------------------------
s({trig = "int ", snippetType="autosnippet"},
  fmta( [[\int_{<>}^{<>} ]], {i(1), i(2)}),
  {condition = tex.in_mathzone}
),


s({trig = "int;", snippetType="autosnippet"},
  fmta( [[\int_{<>} ]], {i(1)}),
  {condition = tex.in_mathzone}
),


s({trig = "intff", snippetType="autosnippet"},
  t( [[\int_{-\infty}{+\infty}]]),
  {condition = tex.in_mathzone}
),

s({trig = "int(%a)f", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\int_{<>}{+\infty}]], {f(utils.capture1)}),
  {condition = tex.in_mathzone}
),

s({trig = "intf(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\int_{-\infty}{<>}]], {f(utils.capture1)}),
  {condition = tex.in_mathzone}
),

s({trig = "int([%a%d])([%a%d]);", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\int_{<>}{<>}]], {f(utils.capture1), f(utils.capture2)}),
  {condition = tex.in_mathzone}
),



--sum-------------------------------------------------------------------------------
s({trig = "sum ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\sum_{<>}^{<>} ]], {i(1), i(2) }),
  {condition = tex.in_mathzone}
),

s({trig = "sum;", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\sum_{<>} ]], { i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "sum(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\sum_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "sum(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\sum_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3)}),
  {condition = tex.in_mathzone}
),



--time-----------------------------------------------------------------------------
s({trig = "prod ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\prod_{<>}^{<>} ]], { i(1), i(2) }),
  {condition = tex.in_mathzone}
),

s({trig = "prod;", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\prod_{<>} ]], { i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "prod(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\prod_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2),  i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "prod(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\prod_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3) }),
  {condition = tex.in_mathzone}
),



-- cap------------------------------------------------------------------------------
s({trig = 'Cap ', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcap_{<>}^{<>} ]], { i(1), i(2) }),
  {condition = tex.in_mathzone}
),

s({trig = "Cap;", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcap_{<>} ]], {i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Cap(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcap_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Cap(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcap_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3)}),
  {condition = tex.in_mathzone}
),



-- cup ----------------------------------------------------------------------------
s({trig = 'Cup ', snippetType="autosnippet"},
  fmta( [[\bigcup_{<>}^{<>} ]], {i(1), i(2) }),
  {condition = tex.in_mathzone}
),

s({trig = "Cup", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcup_{<>} ]], {i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Cup(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcup_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Cup(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigcup_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3)}),
  {condition = tex.in_mathzone}
),


--Land-------------------------------------------------------------------------

s({trig = 'Land ', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigwedge_{<>}^{<>} ]], {i(1), i(2) }),
  {condition = tex.in_mathzone}
),

s({trig = "Land;", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigwedge_{<>} ]], {i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Land(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigwedge_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Land(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigwedge_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3)}),
  {condition = tex.in_mathzone}
),

--Lor----------------------------------------------------------------------------

s({trig = 'Lor ', regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigvee_{<>}^{<>} ]], {i(1), i(2)}),
  {condition = tex.in_mathzone}
),

s({trig = "Lor;", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigvee_{<>} ]], {i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Lor(%a)(%d) ", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigvee_{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2),i(1)}),
  {condition = tex.in_mathzone}
),

s({trig = "Lor(%a)(%d)(%a)", regTrig = true, wordTrig = false, snippetType="autosnippet"},
  fmta( [[\bigvee{<>=<>}^{<>} ]], {f(utils.capture1), f(utils.capture2), f(utils.capture3)}),
  {condition = tex.in_mathzone}
),

}
