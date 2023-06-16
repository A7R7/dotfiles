-- local function reload_module(module_name)
--     package.loaded[module_name] = nil
--     return require(module_name)
-- end
local Util = require("util")
Util.reload_module("core.options")
Util.reload_module("core.lazy")
Util.reload_module("core.keymaps")
Util.reload_module("core.autocmds")

-- vim.keymap.set("n", "<leader>rr", dofile(vim.env.MYVIMRC), {})
