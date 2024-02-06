-- toggleterm
-- https://github.com/akinsho/toggleterm.nvim
local ok, configs = pcall(require, 'toggleterm')
if not ok then return end

configs.setup({
    shade_terminals = true,
})
