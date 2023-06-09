local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup", "help", "lspinfo", "man", "notify", "qf", "query", -- :InspectTree
		"spectre_panel", "startuptime", "tsplayground", },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- auto open pdf in zathura
autocmd("BufReadPost", {
	pattern = { "*.pdf" },
	callback = function()
		local filepath = vim.fn.expand("%:p")
		vim.api.nvim_command("silent !zathura " .. filepath .. " &")
		vim.api.nvim_command("bwipeout!")
	end,
})

-- disable auto format
autocmd({ "FileType" }, {
	pattern = { "lua", "c", "h", },
	callback = function()
		vim.b.autoformat = false
	end,
})

-- autocmd("WinEnter", {
--   group = augroup("active_window_color"),
--   callback = function()
--     vim.opt.winhighlight=Normal:ActiveWindow
--   end,
-- })
