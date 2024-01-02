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

-- Ustawia kursor tam gdzie go zostawiliśmy
autocmd("BufReadPost", {
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})

-- zamyka pliki przy pomocy 'q'
-- https://github.com/loqusion/dotfiles
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q", {}),
    pattern = {
        "git",
        "help",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        vim.keymap.set("n", "d", "<c-d>", { buffer = event.buf, silent = true })
        vim.keymap.set("n", "u", "<c-u>", { buffer = event.buf, silent = true })
    end,
})
