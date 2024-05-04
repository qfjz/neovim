-- lsp-zero
local ok_lsp_zero, lsp_zero = pcall(require, "lsp-zero")
if not ok_lsp_zero then
    return
end

local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
    return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
    return
end

-- local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

if vim.fn.system[[command -v pyright]] ~= "" then
    -- pyright_cmd = vim.fn.system[[command -v pyright]]
    -- vim.notify("PyRight" .. " " .. pyright_cmd)
    PyRight = "pyright"
else
    PyRight = nil
end

mason_lspconfig.setup({
    ensure_installed = {
        PyRight,
    },
    handlers = {
        lsp_zero.default_setup,
    },
    require'lspconfig'.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    },
})
