local function reload_module(module_name)
    package.loaded[module_name] = nil
    return require(module_name)
end
reload_module("core.options")
reload_module("core.lazy")
reload_module("core.keymaps")
reload_module("core.autocmds")

