local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({
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

require('mason-lspconfig').setup({
    ensure_installed = {
        PyRight,
    },
    handlers = {
        lsp_zero.default_setup,
    },
})
