vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.lazy")
require("core.options")
require("core.mappings")
require("core.autocommands")
require("core.docker-yank")
require("config.alpha-cnf")
require("config.autocomplete-cnf")
require("config.barbar-cnf")
require("config.bookmarks-cnf")
require("config.fauxClip-cnf")
require("config.flash-cnf")
require("config.fzflua-cnf")
require("config.gitsigns-cnf")
require("config.headlines-cnf")
require("config.ibl-cnf")
require("config.lf-cnf")
require("config.lsp-zero-cnf")
require("config.lualine-cnf")
require("config.neorg-cnf")
require("config.noice-cnf")
require("config.nvim-notify-cnf")
require("config.oil-cnf")
require("config.persistence-cnf")
require("config.pomo-cnf")
require("config.scope-cnf")
require("config.telescope-cnf")
require("config.todo-comments-cnf")
require("config.toggleterm")
require("config.treesitter-cnf")
require("config.which-key-cnf")
require("config.zen-mode-cnf")
require('config.nvim-autopairs-cnf')
require("plugins.plugins")

require("user_functions.bookmarks")
require("user_functions.git")
require("user_functions.komendy")
require("user_functions.misc")
require("user_functions.notatki")
require("user_functions.write")

vim.cmd([[colorscheme tokyonight]])

-- Ustawienia użytkownika
-- ~/.config/$NVIM_APPNAME/lua/user-settings.lua
local status_ok, _ = pcall(require, "user-settings")
if not status_ok then
    return
end
