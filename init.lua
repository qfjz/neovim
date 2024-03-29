vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.lazy")
require("core.options")
require("core.mappings")
require("core.functions")
require("core.autocommands")
require("core.commands")
require("core.timer-menu")
require("core.hydra-menu")
require("config.which-key-cnf")
require("config.gitsigns-cnf")
require("config.lualine-cnf")
require("config.treesitter-cnf")
require("config.lf-cnf")
require("config.flash-cnf")
require("config.zen-mode-cnf")
require("config.ibl-cnf")
require("config.neorg-cnf")
require("config.nvim-notify-cnf")
require("config.pomo-cnf")
require("config.pears-cnf")
require("config.toggleterm")
require("config.fzflua-cnf")
require("config.noice-cnf")
require("config.lsp-zero-cnf")
require("config.autocomplete-cnf")
require("config.fauxClip-cnf")
require("config.alpha-cnf")
require("config/todo-comments-cnf")
require("config/telescope-cnf")
require("plugins.plugins")

vim.cmd([[colorscheme tokyonight]])

-- Ustawienia użytkownika
-- ~/.config/$NVIM_APPNAME/lua/user-settings.lua
local status_ok, _ = pcall(require, "user-settings")
if not status_ok then
    return
end
