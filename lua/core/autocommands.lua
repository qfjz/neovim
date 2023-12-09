-- autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- wyróżnienie kopiowanego tekstu
autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150,
        })
    end,
})

 -- wyłącza parametry `cro` czyli nie wstawia automatycznie komentarza w kolejnej linii
autocmd({ 'FileType', 'BufEnter' }, {
    pattern = '*',
    command = [[setlocal formatoptions-=cro]]
})
