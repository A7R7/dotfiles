-- vim:fileencoding=utf-8:foldmethod=marker
local Util = require("util")

return {

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
			"jvgrootveld/telescope-zoxide",
      {
        "sudormrfbin/cheatsheet.nvim",
        cmd = { "Cheatsheet" },
      },
		},
		--{{{
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					undo = {
						use_delta = true,
						use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
						side_by_side = true,
						diff_context_lines = vim.o.scrolloff,
						entry_format = "state #$ID, $STAT, $TIME",
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").yank_additions,
								["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
								["<C-cr>"] = require("telescope-undo.actions").restore,
							},
						},
					},
					zoxide = {
						prompt_title = "[ Walking on the shoulders of TJ ]",
						mappings = {
							default = {
								after_action = function(selection)
									print("Update to (" .. selection.z_score .. ") " .. selection.path)
								end,
							},
							["<C-s>"] = {
								before_action = function(selection)
									print("before C-s")
								end,
								action = function(selection)
									vim.cmd.edit(selection.path)
								end,
							},
							-- Opens the selected entry in a new split
							["<C-q>"] = {
								action = require("telescope._extensions.zoxide.utils").create_basic_command("split"),
							},
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("zoxide")
		end,
		cmd = "Telescope",
		-- version = false, -- telescope did only one release, so use HEAD for now
		keys = {
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<c-t>"] = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end,
						["<a-t>"] = function(...) return require("trouble.providers.telescope").open_selected_with_trouble(...) end,
						["<a-i>"] = function() Util.telescope("find_files", { no_ignore = true })() end,
						["<a-h>"] = function() Util.telescope("find_files", { hidden = true })() end,
						["<C-Down>"] = function(...) return require("telescope.actions").cycle_history_next(...) end,
						["<C-Up>"] = function(...) return require("telescope.actions").cycle_history_prev(...) end,
						["<C-f>"] = function(...) return require("telescope.actions").preview_scrolling_down(...) end,
						["<C-b>"] = function(...) return require("telescope.actions").preview_scrolling_up(...) end,
					},
					n = {
						["q"] = function(...) return require("telescope.actions").close(...) end,
					},
				},
			},
		},
		--}}}
	},

	{ "nanotee/zoxide.vim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		--{{{
		keys = {},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			filesystem = {
				-- bind_to_cwd = false,
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
				follow_current_file = true,
			},
			window = {
				width = 30,
				mappings = {
					["<space>"] = false,
					["h"] = "navigate_up",
					["l"] = "set_root",
					["o"] = "open",
					["O"] = "open_with_window_picker",
					["\\"] = "split_with_window_picker",
					["|"] = "vsplit_with_window_picker",
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
			},
		},
		--}}}
	},

	{
		"kevinhwang91/rnvimr",
		cond = false,
		keys = {
			{ "<leader>rg", "<cmd>RnvimrToggle<cr>", desc = "Toggle Ranger" },
		},
	},

	{
		"windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},

	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		cmd = { "Oil" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			require("oil").setup()
		end,
	},
}
