local M = {}
M.starbound_neovim = {}
M.starbound_neovim.logo = function ()
 local logo = [[
   ⠀⠠⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠘⠻⠿⢿⣷⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣆⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⣿⣦⣄⠀⢦⡀⠀⠀⠀⢸⣿⣆⠀⠀⢀⣴⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣷⣜⣿⣦⣶⣾⣿⠿⠿⠿⣿⣿⣿⣇⡀⠀⠀⠀⣀⠀⠀⠀⠀
     ████  ███  ███████████⢿⣿⣿⣟⠋⠁⠀⠀⠀⠀⠀⠈⠙⢿⣿⣶⣶⡟⠁⠀⠀⠀⠀
      ████  ███    ███        ⠀⠙⢿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⡀⠀⠀⠀⠀⠀
      ████ ███    ███        ⠀⠀⠀⠙⢿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣧⣀⣀⣀⠀⠀
      █ █████    ███▄▄▄▄▄▄  ⠀⠀⠀⠀⠀⠻⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⣿⡿⠛⠉⠀⠀⠀
      ██ ████    ███▀▀▀▀▀▀  ⠀⠀⠀⠀⠀⠀⠈⣿⣿⡀⠀⠀⠀⠀⠀⢰⣿⡷⠀⠀⠀⠀⠀
      ███  ███    ███        ⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣆⠀⠀⠀⠀⣼⣿⣷⣄⠀⠀⠀⠀
      ███   ███    ███        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣆⠀⣠⣾⡿⠉⠉⠉⠁⠀⠀⠀
   ⠀⠀███   ████  ███████████⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣯⠛⢇⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀               ██                    ⠀⢻⣧⠀⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀████   ███  ██                    ⠀⠀⢻⣇⠀⠀⠀⠀⠀⠀⠀
   ⠀⠀ ████  ███                           ⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀
   ⠀⠀  ████ ███  ████  ████ ████ ███ ⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀⠀
   ⠀⠀   ██████   ████   █████ █████ ████ ⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠀
   ⠀⠀    █████   ████   ████ ████ ████ ⠀⠀⠀⠀⠀⠈⡄⠀⠀⠀⠀
   ⠀⠀     ████   ████   ████  ████  ████ ⠀⠀⠀⠀⠀⠀⠡⠀⠀⠀⠀
   ⠀⠀      ████   ████   ████  ████  ████ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ██     ████  ████⠀⠀████  ████  ████           
                                                       
]]
 return vim.split(logo, "\n")
end

M.starbound_neovim.color = function ()
  vim.api.nvim_set_hl(0, "starbound_neovim_sun", {fg = "#F4E656"})
  vim.api.nvim_set_hl(0, "starbound_neovim_text", {fg = "#FFFFFF"})
  return {
  {'starbound_neovim_sun', 5, 55},
  {'starbound_neovim_sun', 6, 55},
  {'starbound_neovim_sun', 10, 55},
  {'starbound_neovim_sun', 15, 55},
  {'starbound_neovim_sun', 18, 55},
  {'starbound_neovim_sun', 22, 55},
  {'starbound_neovim_sun', 25, 55},
  {'starbound_neovim_sun', 27, 55},
  {'starbound_neovim_sun', 30, 55},
  {'starbound_neovim_sun', 33, 55},
  {'starbound_neovim_sun', 34, 55},
  {'starbound_neovim_sun', 36, 55},
  {'starbound_neovim_sun', 38, 55},
  {'starbound_neovim_sun', 39, 55},
  {'starbound_neovim_sun', 40, 55},
  {'starbound_neovim_sun', 42, 55},
  {'starbound_neovim_sun', 43, 55},
  {'starbound_neovim_sun', 44, 55},
  {'starbound_neovim_sun', 46, 55},
  {'starbound_neovim_sun', 47, 55},
  {'starbound_neovim_sun', 48, 55},
  {'starbound_neovim_sun', 49, 55},
  {'starbound_neovim_sun', 50, 55},
  {'starbound_neovim_sun', 50, 55},
  {'starbound_neovim_sun', 51, 55}
}
end

M.colorful_nvim = [[
]]
return M
