-- plugins.lua
return {
    "AlexvZyl/nordic.nvim",
    "gbprod/nord.nvim",
    "loctvl842/monokai-pro.nvim",
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
    "rootiest/astral.nvim",
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd.colorscheme[[tokyonight]]
        end,
    },
    "LudoPinelli/comment-box.nvim",
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
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            })
         end
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
    -- "lukas-reineke/headlines.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-eunuch",
    "tpope/vim-repeat",
    -- "tpope/vim-surround",
    "sbulav/nredir.nvim",
    "lewis6991/gitsigns.nvim",
    -- "Jorengarenar/fauxClip",
    "ojroques/vim-oscyank",
    "jamessan/vim-gnupg",
    "nvim-lualine/lualine.nvim",
    "romgrk/barbar.nvim",
    "tiagovla/scope.nvim",
    'folke/todo-comments.nvim',
    "folke/which-key.nvim",
    "doctorfree/cheatsheet.nvim",
    "nvim-lua/popup.nvim",
    "mg979/vim-visual-multi",
    "LintaoAmons/bookmarks.nvim",
    "stevearc/dressing.nvim",
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
    "windwp/nvim-autopairs",
    "nvim-treesitter/nvim-treesitter",
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
    "saadparwaiz1/cmp_luasnip",  -- LuaSnip
    "rafamadriz/friendly-snippets",  -- LuaSnip
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
}
