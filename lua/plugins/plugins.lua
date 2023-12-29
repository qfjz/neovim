-- plugins.lua
return {
    "rose-pine/neovim",
    "catppuccin/nvim",
    "LunarVim/lunar.nvim",
    "rebelot/kanagawa.nvim",
    "sainnhe/everforest",
    "EdenEast/nightfox.nvim",
    "ribru17/bamboo.nvim",
    "LunarVim/horizon.nvim",
    "srcery-colors/srcery-vim",
    "ayu-theme/ayu-vim",
    "bluz71/vim-nightfly-guicolors",
    "gruvbox-community/gruvbox",
    "kristijanhusak/vim-hybrid-material",
    "sainnhe/gruvbox-material",
    "xero/miasma.nvim",
    "olivercederborg/poimandres.nvim",
    "Rigellute/rigel",
    "ibhagwan/fzf-lua",
    "mbbill/undotree",
    "akinsho/toggleterm.nvim",
    "lmburns/lf.nvim",
    "b3nj5m1n/kommentary",
    "vim-scripts/AutoComplPop",
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",
    "ojroques/vim-oscyank",
    "jamessan/vim-gnupg",
    "anuvyklack/hydra.nvim",
    "nvim-lualine/lualine.nvim",
    "romgrk/barbar.nvim",
    "folke/which-key.nvim",
    "folke/flash.nvim",
    "folke/zen-mode.nvim",  -- tryb Zen
    "folke/twilight.nvim",  -- zakreśla tylko bieżący paragraf
    "lukas-reineke/indent-blankline.nvim",  -- pionowe linie wyróżniające wcięcie
    "rcarriga/nvim-notify",
    "epwalsh/pomo.nvim",
    "steelsojka/pears.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        -- keys = {
          -- { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
        -- },
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup()
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
        -- load the colorscheme here
        -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
--         config = function()
--             require("neorg").setup {
--                 load = {
--                     ["core.defaults"] = {}, -- Loads default behaviour
--                     ["core.concealer"] = {}, -- Adds pretty icons to your documents
--                     ["core.dirman"] = { -- Manages Neorg workspaces
--                         config = {
--                             workspaces = {
--                                 home = "~/Sync/Notes/neorg/home",
--                                 work = "~/Sync/Notes/neorg/work",
--                             },
--                         },
--                     },
--                 },
--             }
--         end,
    },
}
