-- vim:fileencoding=utf-8:foldmethod=marker
return {

	-- measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		--{{{
		config = function()
			vim.g.startuptime_tries = 10
		end,
		--}}}
	},

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		--{{{
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
		--}}}
	},

	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- makes some plugins dot-repeatable like leap
	{ "tpope/vim-repeat", event = "VeryLazy" },

	{
		"edluffy/hologram.nvim",
		cond = false,
		--{{{
		opts = {
			autodisplay = true,
		},
		--}}}
	},
	{
		"jackMort/ChatGPT.nvim",
		cond = false,
		--{{{
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		--}}}
	},
	{
		"nvim-neorg/neorg",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		--{{{
		event = "BufEnter",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
		--}}}
	},
}
