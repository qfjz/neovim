vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.lazy")
require("core.options")
require("core.mappings")
require("core.functions")
require("core.autocommands")
require("core.commands")
require("config.which-key-cnf")
require("config.gitsigns-cnf")
require("config.lualine-cnf")
require("config.hydra-cnf")
require("config.treesitter-cnf")
require("config.lf-cnf")
require("config.flash-cnf")
require("plugins.plugins")

vim.cmd([[colorscheme tokyonight]])
