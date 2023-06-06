local Util = require("util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

map("i", "<esc>", "<right><esc>", { silent = true })
-- copy to system clipboard
map("n", "<D-c>", '"+yy', { desc = "Copy to system clipboard" })
map("v", "<D-c>", '"+y', { desc = "Copy to system clipboard" })
map("n", "<A-p>", '"0p', { desc = "Paste last yanked" })
-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- easy insert blank line
map("n", "<cr>", "o<esc>", { desc = "insert newline" })
map("n", "<S-cr>", "O<esc>", { desc = "insert newline" })

if Util.has("smart-splits.nvim") then
	-- Move to window using the <ctrl> hjkl keys
	local split = require("smart-splits")
	map("n", "<C-h>", function()
		split.move_cursor_left()
	end, { desc = "Go to left window" })
	map("n", "<C-j>", function()
		split.move_cursor_down()
	end, { desc = "Go to lower window" })
	map("n", "<C-k>", function()
		split.move_cursor_up()
	end, { desc = "Go to upper window" })
	map("n", "<C-l>", function()
		split.move_cursor_right()
	end, { desc = "Go to right window" })
	map("t", "<C-h>", function()
		split.move_cursor_left()
	end, { desc = "Go to left window" })
	map("t", "<C-j>", function()
		split.move_cursor_down()
	end, { desc = "Go to lower window" })
	map("t", "<C-k>", function()
		split.move_cursor_up()
	end, { desc = "Go to upper window" })
	map("t", "<C-l>", function()
		split.move_cursor_right()
	end, { desc = "Go to right window" })
	-- Resize window using <ctrl> arrow keys
	map("n", "<C-Up>", function()
		split.resize_up()
	end, { desc = "Resize window up" })
	map("n", "<C-Down>", function()
		split.resize_down()
	end, { desc = "Resize window down" })
	map("n", "<C-Left>", function()
		split.resize_left()
	end, { desc = "Resize window left" })
	map("n", "<C-Right>", function()
		split.resize_right()
	end, { desc = "Resize window right" })
	map("t", "<C-Up>", function()
		split.resize_up()
	end, { desc = "Resize window up" })
	map("t", "<C-Down>", function()
		split.resize_down()
	end, { desc = "Resize window down" })
	map("t", "<C-Left>", function()
		split.resize_left()
	end, { desc = "Resize window left" })
	map("t", "<C-Right>", function()
		split.resize_right()
	end, { desc = "Resize window right" })
else
	-- Move to window using the <ctrl> hjkl keys
	map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
	-- Resize window using <ctrl> arrow keys
	map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
	map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
	map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
	map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

--undo
map("n", "<C-z>", "u", { desc = "Undo" })
-- buffers
if Util.has("bufferline.nvim") then
	map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
	map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
	map("n", "<leader>bp", "<cmd>BufferLineTooglePin<cr>", { desc = "Toggle pin" })
	map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Delete unpined" })
else
	map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
	map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bt", "<cmd>terminal<cr>", { desc = "New Terminal Buffer" })

-- Clear search with <esc>
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>n", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")
map("i", "<CR>", "<CR><c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<ESC><cmd>w<cr>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>p", "<cmd>:Lazy<cr>", { desc = "Package" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
	map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
	map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- toggle options
map("n", "<leader>ta", "<cmd>ASToggle<cr>", { desc = "Toggle Autosave"})
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>tc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
map("n", "<leader>tf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>ts", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>tw", function() Util.toggle("wrap") end, { desc = "Toggle Wrap" })
map("n", "<leader>tl", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>td", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>tm", "<cmd>set modifiable!<cr>", { desc = "Toggle Modifiable" })
map("n", "<leader>tr", "<cmd>set readonly!<cr>", { desc = "Toggle Readonly" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ti", vim.show_pos, { desc = "Inspect Pos" })
end

-- lazygit
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root() }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })


-- terminals
-- map("n", "<leader>ft", function() Util.float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
-- map("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})

if Util.has("toggleterm.nvim") then
  map("n", "<A-f>", "<cmd>ToggleTerm direction=float<cr>", {desc = "ToggleTerm float"})
  map("n", "<A-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", {desc = "ToggleTerm horizontal"})
  map("n", "<A-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", {desc = "ToggleTerm vertical"})
  map("t", "<A-f>", "<cmd>ToggleTerm direction=float<cr>", {desc = "ToggleTerm float"})
  map("t", "<A-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", {desc = "ToggleTerm horizontal"})
  map("t", "<A-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", {desc = "ToggleTerm vertical"})
  map("t", "<esc><esc>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {desc = "escape terminal mode"})
end
-- if Util.has("nvterm") then
--   local nvterm = require("nvterm.terminal")
--   map("n", "<A-f>", function() nvterm.toggle "float" end, {desc = "ToggleTerm float"})
--   map("n", "<A-h>", function() nvterm.toggle "horizontal" end, {desc = "ToggleTerm horizontal"})
--   map("n", "<A-v>", function() nvterm.toggle "vertical" end, {desc = "ToggleTerm vertical"})
--   map("t", "<A-f>", function() nvterm.toggle "float" end, {desc = "ToggleTerm float"})
--   map("t", "<A-h>", function() nvterm.toggle "horizontal" end, {desc = "ToggleTerm horizontal"})
--   map("t", "<A-v>", function() nvterm.toggle "vertical" end, {desc = "ToggleTerm vertical"})
-- end
-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w\\", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "\\", "<C-W>s", { desc = "Split window below" })
map("n", "|",  "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<C-q>", "<C-W>c", { desc = "Delete window" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

if Util.has("telescope-zoxide") then
  map("n", "<leader>z", function () require("telescope").extensions.zoxide.list() end, { desc = "zoxide"})
end

if Util.has("neo-tree.nvim") then
  local neo_cmd = require("neo-tree.command")
  map("n", "<leader>te",
    function() neo_cmd.execute({ toggle = true, dir = require("util").get_root() }) end,
    {desc = "Toggle neo-tree"}
  )
  map("n", "<leader>e",
    function()
      if vim.bo.filetype == "neo-tree"
      then vim.cmd.wincmd "p"
      else vim.cmd.Neotree "focus" end
    end,
    {desc = "toggle neo-tree"})
end
