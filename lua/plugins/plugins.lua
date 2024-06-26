-- plugins.lua
return {
    "AlexvZyl/nordic.nvim",
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
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd.colorscheme[[tokyonight]]
        end,
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
    "stevearc/oil.nvim",
    "lmburns/lf.nvim",
    "ThePrimeagen/harpoon",
    "ibhagwan/fzf-lua",
    "nvim-telescope/telescope.nvim",
    "mbbill/undotree",
    "akinsho/toggleterm.nvim",
    "goolord/alpha-nvim",
    "b3nj5m1n/kommentary",
    "tpope/vim-fugitive",
    "tpope/vim-eunuch",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "sbulav/nredir.nvim",
    "lewis6991/gitsigns.nvim",
    -- "Jorengarenar/fauxClip",
    "ojroques/vim-oscyank",
    "jamessan/vim-gnupg",
    "anuvyklack/hydra.nvim",
    "nvim-lualine/lualine.nvim",
    "romgrk/barbar.nvim",
    'folke/todo-comments.nvim',
    "folke/which-key.nvim",
    "doctorfree/cheatsheet.nvim",
    "nvim-lua/popup.nvim",
    "mg979/vim-visual-multi",
    "LintaoAmons/easy-commands.nvim",
    {
        "LintaoAmons/bookmarks.nvim",
        dependencies = {
            {"stevearc/dressing.nvim"} -- optional: to have the same UI shown in the GIF
        }
    },
    { "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
    },
    "folke/flash.nvim",
    "folke/zen-mode.nvim",  -- tryb Zen
    "folke/twilight.nvim",  -- zakreśla tylko bieżący paragraf
    "lukas-reineke/indent-blankline.nvim",  -- pionowe linie wyróżniające wcięcie
    "HiPhish/rainbow-delimiters.nvim",
    "rcarriga/nvim-notify",
    "folke/noice.nvim",
    "epwalsh/pomo.nvim",
    "steelsojka/pears.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
    },
    {
        "nvim-neorg/neorg",
        version = "v7.0.0",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}
