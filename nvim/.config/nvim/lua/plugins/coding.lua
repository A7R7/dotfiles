-- vim:fileencoding=utf-8:foldmethod=marker

return {
	{
		"L3MON4D3/LuaSnip", --  snippets
		--{{{
		--
		opts = {
			history = true,
			update_events = { "TextChanged", "TextChangedI" },
			delete_check_events = "TextChanged",
			enable_autosnippets = true,
			store_selection_keys = "<Tab>",
		},

		config = function(_, opts)
			require("luasnip").config.set_config(opts)
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/luaSnip/" })
		end,

    -- stylua: ignore
    keys = {
      { "<a-l>", function() local ls = require("luasnip") if ls.locally_jumpable() then ls.jump(1) end end, mode = {"n", "i", "s" } },
      { "<a-h>", function() local ls = require("luasnip") if ls.locally_jumpable() then ls.jump(-1) end end, mode = {"n", "i", "s" } },
      {
        "<Leader>lr",
        function ()
          require("luasnip.loaders.from_lua").lazy_load({paths="~/.config/nvim/luasnip/"})
          require("notify")("snippets reloaded", nil, {title = "LuaSnip"})
        end,
        desc = "reload luasnip snippets",
      },
    },
		--}}}
	},

	{
		"hrsh7th/nvim-cmp", --  auto completion
		--{{{
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = function(_, item)
						local icons = require("util.icons").kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
		--}}}
	},

	{
		"echasnovski/mini.pairs", --  auto pairs
		cond = false,
		--{{{
		--
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
		--}}}
	},

	{
		"windwp/nvim-autopairs", --  auto pairs
		-- lazy = false,
		--{{{
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim", "tex" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
		--}}}
	},

	{
		"LunarWatcher/auto-pairs",
		cond = false,
		--{{{
		config = function(_, opts)
			vim.g.AutoPairsFiletypeBlacklist = { "tex" }
			require("auto-pairs").setup(opts)
		end,
		--}}}
	},

	{
		"echasnovski/mini.surround", --  surround
		--{{{
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup(opts)
		end,
		--}}}
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring", --  coments
		lazy = true,
		--{{{
		--
		--}}}
	},

	{
		"echasnovski/mini.comment", --  comments
		event = "VeryLazy",
		--{{{
		--
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
		--}}}
	},

	{
		"echasnovski/mini.ai", --  better text-objects
		--{{{
		--
		-- keys = {
		--   { "a", mode = { "x", "o" } },
		--   { "i", mode = { "x", "o" } },
		-- },
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			-- register all text objects with which-key
			if require("util").has("which-key.nvim") then
				---@type table<string, string|table>
				local i = {
					[" "] = "Whitespace",
					['"'] = 'Balanced "',
					["'"] = "Balanced '",
					["`"] = "Balanced `",
					["("] = "Balanced (",
					[")"] = "Balanced ) including white-space",
					[">"] = "Balanced > including white-space",
					["<lt>"] = "Balanced <",
					["]"] = "Balanced ] including white-space",
					["["] = "Balanced [",
					["}"] = "Balanced } including white-space",
					["{"] = "Balanced {",
					["?"] = "User Prompt",
					_ = "Underscore",
					a = "Argument",
					b = "Balanced ), ], }",
					c = "Class",
					f = "Function",
					o = "Block, conditional, loop",
					q = "Quote `, \", '",
					t = "Tag",
				}
				local a = vim.deepcopy(i)
				for k, v in pairs(a) do
					a[k] = v:gsub(" including.*", "")
				end

				local ic = vim.deepcopy(i)
				local ac = vim.deepcopy(a)
				for key, name in pairs({ n = "Next", N = "Last" }) do
					i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
					a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
				end
				require("which-key").register({
					mode = { "o", "x" },
					i = i,
					a = a,
				})
			end
		end,
		--}}}
	},
}