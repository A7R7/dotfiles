if vim.g.neovide then
	-- vim.o.guifont = "DejaVuSansM Nerd Font Propo"
	-- vim.o.guifont = "Fira Code Medium Nerd Font Complete"
	-- vim.o.guifont = "Fira Code Nerd Font Mono"
	-- vim.o.guifont = "CaskaydiaCove Nerd Font Mono"
	-- vim.o.guifont = "SpaceMono Nerd Font Mono"
	-- vim.o.guifont = "iosevka"
	-- vim.o.guifont = "Sarasa Term SC Nerd"
	-- vim.o.guifont = "Hack Nerd Font Propo" -- good
	-- vim.o.guifont = "FiraCode Nerd Font Propo" -- like
	vim.o.guifont = "FiraMono Nerd Font Propo" -- best

	vim.g.neovide_no_idle = true
	vim.g.neovide_transparency = 0.90
	--  vim.g.neovide_cursor_vfx_mode = "railgun"
	--  vim.g.neovide_cursor_vfx_mode = "torpedo"
	--  vim.g.neovide_cursor_vfx_mode = "pixiedust"
	--  vim.g.neovide_cursor_vfx_mode = "sonicboom"
	--  vim.g.neovide_cursor_vfx_mode = "ripple"
	vim.g.neovide_cursor_vfx_mode = "wireframe"
	--  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	--  vim.g.neovide_cursor_vfx_particle_density = 16.0
	--  vim.g.neovide_cursor_vfx_particle_speed = 9.0
	--  vim.g.neovide_cursor_vfx_particle_phase = 3
	--  vim.g.neovide_cursor_vfx_particle_curl = 0.03
	vim.g.neovide_scale_factor = 1.1
	vim.keymap.set("n", "<C-=>", function()
		if vim.g.neovide_scale_factor < 3 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05
		end
	end)
	vim.keymap.set("n", "<C-->", function()
		if vim.g.neovide_scale_factor > 0.5 then
			vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05
		end
	end)
end
