-- autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- wyróżnienie kopiowanego tekstu
autocmd("TextYankPost", {
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
autocmd({ "FileType", "BufEnter" }, {
    pattern = '*',
    command = [[setlocal formatoptions-=cro]]
})

-- Ustawia kursor tam gdzie go zostawiliśmy
autocmd("BufReadPost", {
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})

-- zamyka pliki przy pomocy 'q'
-- https://github.com/loqusion/dotfiles
autocmd("FileType", {
    group = augroup("close_with_q", {}),
    pattern = {
        "git",
        "help",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>l", "<c-]>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "<c-t>", { noremap = true })
        vim.keymap.set("n", "d", "<c-d>", { buffer = event.buf, silent = true })
        vim.keymap.set("n", "u", "<c-u>", { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "K", 'viwy:help <c-r>"<cr>', { noremap = true })
    end,
})

-- Klawisz `K` w plikach sh wywołuje pomoc dla wyrazu pod kursorem
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "K", 'viwy:Man <c-r>"<cr>', { noremap = true })
    end,
})

vim.api.nvim_create_augroup("Markdown", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "markdown",
    },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "1", "<cmd>norm I# <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "2", "<cmd>norm I## <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "3", "<cmd>norm I###  <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "3", "<cmd>norm I#### <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "i", ",c", ":norm I```", { noremap = true })
    end,
    group = "Markdown",
})

vim.api.nvim_create_augroup("Neorg", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "norg",
    },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "1", [[<cmd>norm o* <cr>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "2", [[<cmd>norm o** <cr>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "3", [[<cmd>norm o*** <cr>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "4", [[<cmd>norm o**** <cr>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "i", ",c", [[<esc><cmd>norm I@code @end<cr><cmd>norm bb<cr><cmd>startinsert<cr>]], { noremap = true })

    end,
    group = "Neorg",
})

autocmd("BufEnter", {
    group = augroup("iblenable", {}),
    pattern = "*",
    command = [[IBLEnable]]
})

autocmd("BufEnter", {
    group = augroup("ibldisable", {}),
    pattern = {
        "*.norg",
        "*.md",
    },
    command = [[IBLDisable]]
})

autocmd("BufNewFile", {
    pattern = { "*.sh" },
    command = [[0r ~/.config/nvim/templates/bash.sh]]
})
