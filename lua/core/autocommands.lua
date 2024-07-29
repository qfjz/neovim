-- autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- DESC: wyróżnienie kopiowanego tekstu
autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",  -- :h highlight-groups
            timeout = 100,
        })
    end,
})

-- DESC: Kopiuje dane z rejestru " do schowka systemowego przy połączeniu SSH
local SSH_Client = os.getenv("SSH_CLIENT")
if SSH_Client ~= nil then
    autocmd("TextYankPost", {
        group = augroup("OSC", { clear = true }),
        pattern = "*",
        callback = function()
            -- Kopiuje do hosta tylko operacje (y)ank, użycie komend c, d nie kopiuje do hosta
            if vim.api.nvim_eval("v:event.operator") == "y" then
                vim.cmd[[OSCYankRegister "]]
            end
            -- vim.cmd[[OSCYankRegister "]]
        end,
    })
end

 -- DESC: wyłącza parametry `cro` czyli nie wstawia automatycznie komentarza w kolejnej linii
autocmd({ "FileType", "BufEnter" }, {
    pattern = "*",
    command = [[setlocal formatoptions-=cro]]
})

-- DESC: Ustawia kursor tam gdzie go zostawiliśmy
autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- DESC: zamyka pliki przy pomocy 'q'
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

autocmd("FileType", {
    pattern = { "lua" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "K", 'viwy:help <c-r>"<cr>', { noremap = true })
    end,
})

-- DESC: Klawisz `K` w plikach sh wywołuje pomoc dla wyrazu pod kursorem
autocmd("FileType", {
    pattern = { "sh" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "K", 'viwy:Man <c-r>"<cr>', { noremap = true })
    end,
})

autocmd("FileType", {
    group = augroup("Markdown", { clear = true }),
    pattern = {
        "markdown",
    },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "1", "<cmd>norm I# <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "2", "<cmd>norm I## <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "3", "<cmd>norm I###  <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "4", "<cmd>norm I#### <cr>A", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "i", ",c", ":norm I```", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>sh", [[/^##\+ .*<CR>]], { silent = true, noremap = true, desc = "Wyszukanie nagłówków ##" })
    end,
})

autocmd("FileType", {
    group = augroup("Neorg", { clear = true }),
    pattern = {
        "norg",
    },
    callback = function()
        -- vim.api.nvim_buf_set_keymap(0, "n", "1", [[<cmd>norm o* <cr>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "1", [[o* ]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "2", [[o** ]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "3", [[o*** ]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "4", [[o**** ]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "i", ",c", [[<esc>o@code@end<esc>O]], { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>sh", [[/^\*\*\+ .*<CR>]], { silent = true, noremap = true, desc = "Wyszukanie nagłówków **" })
    end,
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
    command = "0r $HOME/.config/" .. NvimAppName() .. "/templates/bash.sh"
})

autocmd("FileType", {
    group = augroup("vertical_help", { clear = true }),
    pattern = "help",
    callback = function()
        vim.bo.bufhidden = "unload"
        vim.cmd.wincmd("L")
        vim.cmd.wincmd("=")
    end,
})

--  DESC:Automatically update changed file in Vim
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- command = [[silent! if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif]],
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.fn.mode() ~= "c" then
            for _, v in ipairs(vim.fn.getbufinfo("%")) do
                if v.name ~= "" then
                    vim.cmd[[checktime]]
                end
            end
        end
    end
})

-- DESC: Notification after file change
autocmd("FileChangedShellPost", {
    callback = function()
        MSG = "File changed on disk. Buffer reloaded."
        vim.notify(MSG, "info", {
            timeout = 6000,
            title = "File changed",
        })
    end,
})

-- DESC: wchodzi w tryb INSERT przy otworzeniu NOWEGO pliku
autocmd({ "BufNewFile" }, {
    command = [[startinsert]],
})

-- DESC: Informacja o rozpoczęciu nagrywania makra
-- autocmd({ "RecordingEnter", }, {
--     group = augroup("NotifyMacroStart", { clear = true }),
--     callback = function()
--         local msg = "Nagrywam makro " .. "[" .. vim.fn.reg_recording() .. "]"
--         vim.notify(msg, "info", { timeout = 6000, })
--     end,
-- })

-- DESC: Informacja o zakończeniu nagrywania makra
autocmd({ "RecordingLeave", }, {
    group = augroup("NotifyMacroStop", { clear = true }),
    callback = function()
        local msg = "Zakończyłem nagrywać makro " .. "[" .. vim.fn.reg_recording() .. "]"
        vim.notify(msg, "info", {
            timeout = 6000,
        })
    end,
})

-- DESC: Odświerzanie lualine przy nagrywaniu makra
local lualine = require("lualine")
autocmd("RecordingEnter", {
    callback = function()
        lualine.refresh()
    end,
})

-- DESC: Odświerzanie lualine przy zakończeniu nagrania makra
autocmd("RecordingLeave", {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
        50,
        0,
        vim.schedule_wrap(function()
            lualine.refresh()
        end)
        )
    end,
})

-- DESC: Show cursor line only in active window
local cursorGrp = augroup("CursorLine", { clear = true })
autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
autocmd({ "InsertEnter", "WinLeave" }, { pattern = "*", command = "set nocursorline", group = cursorGrp })
