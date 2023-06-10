-- vim:fileencoding=utf-8:foldmethod=marker

local M = {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		-- {{{
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			light_style = "day",
			transparent = not vim.g.neovide,
			lualine_bold = true,
			-- dim_inactive = true,
			day_brightness = 0.2,
			on_highlights = function(hl, c)
				hl.LineNr = { fg = "#7AA2F7" }
				hl.CursorLineNr = { fg = c.orange, bold = true }
				hl.Cursor = { bg = c.white }
				hl.WinSeparator = { fg = c.border_highlight, bg = c.bg, bold = false } -- the column separating vertically split windows
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			-- require("notify").setup({
			-- 	background_colour = "#000000",
			-- })
			vim.cmd([[set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff500-blinkon500-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175 ]])
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
	{
		"AstroNvim/astrotheme",
		--{{{
		config = function()
			require("astrotheme").setup({
				palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`

				termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

				terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

				plugin_default = "auto", -- Sets how all plugins will be loaded
				-- "auto": Uses lazy / packer enabled plugins to load highlights.
				-- true: Enables all plugins highlights.
				-- false: Disables all plugins.

				plugins = { -- Allows for individual plugin overides using plugin name and value from above.
					["bufferline.nvim"] = false,
				},

				palettes = {
					global = { -- Globaly accessible palettes, theme palettes take priority.
						my_grey = "#ebebeb",
						my_color = "#ffffff",
					},
					astrodark = { -- Extend or modify astrodarks palette colors
						red = "#800010", -- Overrides astrodarks red color
						my_color = "#000000", -- Overrides global.my_color
					},
				},

				highlights = {
					global = { -- Add or modify hl groups globaly, theme specific hl groups take priority.
						modify_hl_groups = function(hl, c)
							hl.PluginColor4 = { fg = c.my_grey, bg = c.none }
						end,
						["@String"] = { fg = "#ff00ff", bg = "NONE" },
					},
					astrodark = {
						-- first parameter is the highlight table and the second parameter is the color palette table
						modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
							hl.Comment.fg = c.my_color
							hl.Comment.italic = true
						end,
						["@String"] = { fg = "#ff00ff", bg = "NONE" },
					},
				},
			})
		end,
		--}}}
	},
  {
    'maxmx03/fluoromachine.nvim',
    config = function ()
      local fm = require 'fluoromachine'
      fm.setup {
        glow = true,
        theme = 'fluoromachine'
      }
      vim.cmd.colorscheme 'fluoromachine'
    end
  }
}

M.name = "tokyonight-storm"

function M.config()
	local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
	if not status_ok then
		return
	end
end

return M
