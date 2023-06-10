-- vim:fileencoding=utf-8:foldmethod=marker

return {
	{
		"rcarriga/nvim-notify", -- Better `vim.notify()`
		-- {{{
		--
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 2000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			top_down = false,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
		--}}}
	},

	{
		"stevearc/dressing.nvim", -- better vim.ui
		--{{{
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
		--}}}
	},

	{
		"akinsho/bufferline.nvim", -- bufferline
		--{{{
		event = "VeryLazy",
		opts = {
			options = {
				-- hover = { enabled = true, delay = 200, reveal = { "close" } },
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("util.icons").diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						highlight = "Directory",
						-- text = "Neo-tree",
						-- text_align = "left",
					},
				},
			},
		},
		--}}}
	},

	{ "rebelot/heirline.nvim", opts = function() end },

	{
		"nvim-lualine/lualine.nvim", -- statusline
		--{{{
		event = "VeryLazy",
		opts = function(plugin)
			local icons = require("util.icons")

			local function fg(name)
				return function()
					---@type {foreground?:number}?
					local hl = vim.api.nvim_get_hl_by_name(name, true)
					return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
				end
			end

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", icons_enabled = true, icon = "" },
					},
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
					},
					lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement")
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant") ,
            },
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = fg("Special"),
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = "", padding = { left = 1, right = 1 }, icon = { "" } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree" },
			}
		end,
		--}}}
	},

	{
		"lukas-reineke/indent-blankline.nvim", -- indent guide lines for Neovim
		--{{{
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
		--}}}
	},

	{
		"echasnovski/mini.indentscope", -- active indent guide and indent text objects
		--{{{
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
		--}}}
	},

	-- noicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		cond = function()
			if vim.g.neovide then
				return false
			end
			return true
		end,
		--{{{
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
		--}}}
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		--{{{
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = require("util.alpha").starbound_neovim.logo()
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.val = {
				-- dashboard.button("f", "󰈞 " .. " - Find file", "<cmd>Telescope find_files <CR>"),
				-- dashboard.button("n", " " .. " - New file", "<cmd>ene <BAR> startinsert <CR>"),
				--     dashboard.button("g", "󰊄 " .. " - Find text", "<cmd>Telescope live_grep <CR>"),
        dashboard.button("r", " " .. " - Recent files", "<cmd> Telescope oldfiles <CR>"),
        dashboard.button("s", " " .. " - Restore Session", [[<cmd>lua require("persistence").load() <cr>]]),
				dashboard.button("z", "󰰶 " .. " - Zoxide", [[<cmd>lua require("telescope").extensions.zoxide.list()<cr>]]),
				dashboard.button("t", " " .. " - Terminal", "<cmd>terminal<cr>"),
				dashboard.button("c", " " .. " - Config", "<cmd>e $MYVIMRC <CR>"),
				dashboard.button("p", " " .. " - Packages", "<cmd>Lazy<CR>"),
				dashboard.button("q", "󰅖 " .. " - Quit", "<cmd>qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 1
			return dashboard
		end,

		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
		--}}}
	},

	-- lsp symbol navigation for lualine
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		--{{{
		init = function()
			vim.g.navic_silence = true
			require("util").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("util.icons").kinds,
			}
		end,
		--}}}
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"anuvyklack/pretty-fold.nvim",
		--{{{
		config = function(_, opts)
			require("pretty-fold").setup(opts)
		end,
		--}}}
	},

	{
		"dstein64/nvim-scrollview",
		--{{{
		opts = {
			excluded_filetypes = { "nerdtree" },
			current_only = true,
			winblend = 75,
			base = "buffer",
			column = 80,
		},
		--}}}
	},
}
