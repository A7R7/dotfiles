-- vim:fileencoding=utf-8:foldmethod=marker
return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		-- {{{
		lazy = true,
		opts = {
			style = "storm",
			transparent = not vim.g.neovide,
			on_highlights = function(hl, c)
				hl.LineNr = { fg = c.orange }
				hl.CursorLineNr = { fg = c.orange, bold = true }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = false })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = false })
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
		-- }}}
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		-- {{{
		lazy = true,
		name = "catppuccin",
		-- }}}
	},
	{
		"navarasu/onedark.nvim",
		-- {{{
		lazy = true,
		name = "onedark",
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
		-- }}}
	},
	{
		"sainnhe/sonokai",
		-- {{{
		lazy = true,
		name = "sonokai",
		config = function()
			vim.g.sonokai_style = "andromeda"
		end,
		-- }}}
	},
}
