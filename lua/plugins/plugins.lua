-- plugins.lua
return {
    "rose-pine/neovim",
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
    "folke/which-key.nvim",
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
        -- lazy-load on filetype
        ft = "norg",
        -- options for neorg. This will automatically call `require("neorg").setup(opts)`
        opts = {
            load = {
                ["core.defaults"] = {},
            },
        },
    },
}
