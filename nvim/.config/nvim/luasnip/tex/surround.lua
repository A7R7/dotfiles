local utils = require("_utils")
return {
	s({ trig = "(", snippetType = "autosnippet", wordTrig = false }, { t("("), i(1), t(")") }),
	s({ trig = "[", snippetType = "autosnippet", wordTrig = false }, { t("["), i(1), t("]") }),
	s({ trig = "{", snippetType = "autosnippet", wordTrig = false }, { t("{"), i(1), t("}") }),
	s({ trig = [[lf(]], snippetType = "autosnippet", wordTrig = false }, { t("\\left("), i(1), t("\\right)") }),
	s({ trig = [=[lf[]=], snippetType = "autosnippet", wordTrig = false }, { t("\\left["), i(1), t("\\right]") }),
	s({ trig = [[lf{]], snippetType = "autosnippet", wordTrig = false }, { t("\\left{"), i(1), t("\\right}") }),
}
