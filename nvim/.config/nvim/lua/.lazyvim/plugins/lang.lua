return {
	{
		"lervag/vimtex",
		-- lazy = true,
		config = function()
			vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" }
			vim.g.vimtex_compiler_latexrun_engines = { _ = "xelatex" }
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_continuous_preview = 1
			vim.g.vimtex_syntax_conceal_disable = 1
			vim.g.vimtex_syntax_nospell_comment = 1
			vim.g.vimtex_view_method = "zathura"
			-- require("nvim-treesitter.configs").setup ({
			--   highlight = { enable = true, disable = {"latex"}, },
			-- })
		end,
		ft = "tex",
	},

	{
		"elkowar/yuck.vim",
		ft = "yuck",
	},
	{
		"Shirk/vim-gas",
		ft = "asm",
	},
	{
		"kaarmu/typst.vim",
		ft = "typst",
		keys = {
			{ "<leader>tw", "<cmd>TypstWatch<cr>", desc = "Typst watch compile" },
		},
	},
}
