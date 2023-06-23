local Util = require("util")

local function register(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    local _opts = nil
    if type(opts) == "string" then
      _opts = {desc = opts, silent = true}
    elseif type(opts) == "table" then
      _opts = opts
      _opts.silent = opts.silent ~= false
    else
      _opts = {silent = true}
    end
    vim.keymap.set(mode, lhs, rhs, _opts)
  end
end

local function map(mode, lhs, rhs, opts)
  if type(mode) == "string" then
    register(mode, lhs, rhs, opts)
  elseif type(mode) == "table" then
    for _, _mode in ipairs(mode) do
      register(_mode, lhs, rhs, opts)
    end
  end
end

map("i", "<esc>", "<right><esc>", { silent = true })

-- easy movement
  map({"n", "v"}, "H", '^', {desc = "Goto line start"})
  map({"n", "v"}, "L", '$', {desc = "Goto line end"})
  map({"n", "v"}, "J", '<C-d>', {desc = "Move down"})
  map({"n", "v"}, "K", '<C-u>', {desc = "Move up"})
  map({"n", "v"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  map({"n", "v"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--join  union
  map("n", "<C-u>", "J", {desc = "union 2 line"})
  map("i", "<C-u>", "<esc>Ji", {desc = "union 2 line"})
-- easy insert blank line
  map("n", "<cr>", "o<esc>", { desc = "insert newline" })
  map("n", "<S-cr>", "O<esc>", { desc = "insert newline" })
-- -- clipboard
--   --copy to system clipboard
--   map("n", "<C-c>", '"+yy', { desc = "Copy line to system clipboard" })
--   map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
--   --paste from system clipboard
--   map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
--   map("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })
--   map("c", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })
--   --paste last yanked
--   map("n", "<C-p>", '"0p', { desc = "Paste last yanked" })
--   map("v", "<C-p>", '"0p', { desc = "Paste last yanked" })
--   map("c", "<C-p>", '<C-r>"', { desc = "Paste from neovim clipboard" })
-- -- enter v-block faster
-- map("n", "vv", '<C-v>', { desc = "Copy to system clipboard" })
-- better up/down

-- windows
  map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
  map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
  map("n", "<leader>w\\", "<C-W>s", { desc = "Split window below" })
  map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
  map("n", "\\", "<C-W>s", { desc = "Split window below" })
  map("n", "|",  "<C-W>v", { desc = "Split window right" })
  map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
  map("n", "<C-q>", "<C-W>c", { desc = "Delete window" })

if Util.has("smart-splits.nvim") then
	-- Move to window using the <ctrl> hjkl keys
	local split = require("smart-splits")
	map({"n", "t"}, "<C-h>",  split.move_cursor_left, { desc = "Go to left window" })
	map({"n", "t"}, "<C-j>",  split.move_cursor_down, { desc = "Go to lower window" })
	map({"n", "t"}, "<C-k>",  split.move_cursor_up, { desc = "Go to upper window" })
	map({"n", "t"}, "<C-l>",  split.move_cursor_right, { desc = "Go to right window" })
	-- Resize window using <ctrl> arrow keys
	map({"n", "t"}, "<C-Up>",    split.resize_up,    { desc = "Resize window up" })
	map({"n", "t"}, "<C-Down>",  split.resize_down,  { desc = "Resize window down" })
	map({"n", "t"}, "<C-Left>",  split.resize_left,  { desc = "Resize window left" })
	map({"n", "t"}, "<C-Right>", split.resize_right, { desc = "Resize window right" })
-- swapping buffers between windows
  map('n', '<leader><C-h>', split.swap_buf_left,  { desc = "Swap window left"})
  map('n', '<leader><C-j>', split.swap_buf_down,  { desc = "Swap window down"})
  map('n', '<leader><C-k>', split.swap_buf_up,    { desc = "Swap window up"})
  map('n', '<leader><C-l>', split.swap_buf_right, { desc = "Swap window right"})
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
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

--undo
map("n", "<C-z>", "u", { desc = "Undo" })
-- buffers
if Util.has("bufferline.nvim") then
	-- map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	-- map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
	map("n", "<C-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<C-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
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
map( "n", "<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({"n","x", "o"}, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({"n","x", "o"}, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

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

-- highlights nder cursor
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
  map({"n", "t"}, "<A-f>", "<cmd>ToggleTerm direction=float<cr>", {desc = "ToggleTerm float"})
  map({"n", "t"}, "<A-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", {desc = "ToggleTerm horizontal"})
  map({"n", "t"}, "<A-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", {desc = "ToggleTerm vertical"})
  map("t", "<esc><esc>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {desc = "escape terminal mode"})
end


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

map("n", "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" )
map("n", "<leader>/", Util.telescope("live_grep"), "Find in Files (Grep)" )
map("n", "<leader>:", "<cmd>Telescope command_history<cr>", "Command History" )
map("n", "<leader><space>", Util.telescope("files"), "Find Files (root dir)" )
--  find
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers" )
map("n", "<leader>ff", Util.telescope("files"), "Find Files (root dir)" )
map("n", "<leader>fF", Util.telescope("files", { cwd = false }), "Find Files (cwd)" )
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent" )
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help Pages" )
--  git
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", "commits" )
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", "status" )
-- search
map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", "Auto Commands" )
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" )
map("n", "<leader>sc", "<cmd>Telescope command_history<cr>", "Command History" )
map("n", "<leader>sC", "<cmd>Telescope commands<cr>", "Commands" )
map("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", "Diagnostics" )
map("n", "<leader>sg", Util.telescope("live_grep"), "Grep (root dir)" )
map("n", "<leader>sG", Util.telescope("live_grep", { cwd = false }), "Grep (cwd)" )
map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", "Search Highlight Groups" )
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", "Key Maps" )
map("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", "Man Pages" )
map("n", "<leader>sm", "<cmd>Telescope marks<cr>", "Jump to Mark" )
map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", "Options" )
map("n", "<leader>sR", "<cmd>Telescope resume<cr>", "Resume" )

local symbols = {"Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property",}
map("n", "<leader>ss", Util.telescope("lsp_document_symbols", { symbols = symbols, }), "Goto Symbol")
map("n", "<leader>sS", Util.telescope("lsp_workspace_symbols", { symbols = symbols, }), "Goto Symbol (Workspace)")

map("n", "<leader>su", "<cmd>Telescope undo<cr>", "Undo Tree")
map("n", "<leader>sw", Util.telescope("grep_string"), "Word (root dir)")
map("n", "<leader>sW", Util.telescope("grep_string", { cwd = false }), "Word (cwd)")
map("n", "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), "Colorscheme with preview")

if Util.has("cheatsheet") then
  map("n", "<leader>?", "<cmd>cheatsheet<cr>", {desc = "Cheatsheet"})
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

-- watch compile
map ("n", "<leader>ll",
  function ()
    if vim.bo.filetype == "typst" then
      vim.cmd("TypstWatch")
    elseif vim.bo.filetype == "tex" then
      vim.cmd("VimtexCompile")
    end
  end,
  {desc = "Watch compile"} )

-- -- luasnip
if Util.has("luasnip") then
  local ls = require("luasnip")
  map ("i", "<tab>", function() return ls.jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end, {})
  map ("n", "<leader>lr",
    function()
      require("luasnip.loaders.from_lua").lazy_load({paths="~/.config/nvim/luasnip/"})
      require("notify")("snippets reloaded", nil, {title = "LuaSnip"})
    end,
    "reload luasnip snippets"
  )
end

map ("n", "<leader>rk", function() vim.cmd("mapclear") Util.reload_module("core.keymaps") end, {desc = "reload keymaps"})
map ("n", "<leader>yk", function() require("notify")("it is a test message!") end, {desc = "test"})
