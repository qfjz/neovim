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
    "HiPhish/rainbow-delimiters.nvim",
    "rcarriga/nvim-notify",
    "folke/noice.nvim",
    "epwalsh/pomo.nvim",
    "steelsojka/pears.nvim",
    "ThePrimeagen/harpoon",
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
            -- vim.cmd.colorscheme[[tokyonight]]
        end,
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-path",
}
