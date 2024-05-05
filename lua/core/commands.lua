-- commands
vim.api.nvim_create_user_command("Kolory", "FzfLua colorschemes", {})
vim.api.nvim_create_user_command("KolorPora", "lua KolorPora()", {})
vim.api.nvim_create_user_command("CDFD", "lua CDFD()", {})
vim.api.nvim_create_user_command("CD", "lua CD()", {})
vim.api.nvim_create_user_command("CDE", "lua CDE()", {})
vim.api.nvim_create_user_command("DesFree", "lua DesFree()", {})
vim.api.nvim_create_user_command("EditBmDirs", "lua EditBmDirs()", {})
vim.api.nvim_create_user_command("CDG", "lua CDG()", {})
vim.api.nvim_create_user_command("NvimAppName", "lua vim.notify(NvimAppName())", {})
vim.api.nvim_create_user_command("Config", "lua NvimConfig()", {})
vim.api.nvim_create_user_command("Skroty", "lua Skroty()", {})
vim.api.nvim_create_user_command("Fileinfo", "lua FileInfo()", {})
vim.api.nvim_create_user_command("PU", "lua PU()", {})
vim.api.nvim_create_user_command("GP", "lua GP()", {})
vim.api.nvim_create_user_command("GPS", "lua GPS()", {})
vim.api.nvim_create_user_command("GI", "lua GI()", {})
vim.api.nvim_create_user_command("F", "lua Files()", {})
vim.api.nvim_create_user_command("Files", "lua Files()", {})
vim.api.nvim_create_user_command("GF", "lua GitFiles()", {})
vim.api.nvim_create_user_command("GFiles", "lua GitFiles()", {})
vim.api.nvim_create_user_command("GitFiles", "lua GitFiles()", {})
vim.api.nvim_create_user_command("OstatniaAktualizacja", "lua OstatniaAktualizacja()", {})
vim.api.nvim_create_user_command("TermGitStatus", "lua require'toggleterm'.exec('git status', 1, 22)", {})
vim.api.nvim_create_user_command("TermGitPull", "lua require'toggleterm'.exec('git pull', 1, 12)", {})
vim.api.nvim_create_user_command("TermPs", "lua require'toggleterm'.exec('ps ax', 1, 12)", {})
vim.api.nvim_create_user_command("BmFiles", "lua BmFiles()", {})
vim.api.nvim_create_user_command("AddBmFile", "lua AddBMFile()", {})
vim.api.nvim_create_user_command("EditBmFiles", "lua EditBmFiles()", {})
vim.api.nvim_create_user_command("BufInfo", "lua BufInfo()", {})
vim.api.nvim_create_user_command("EditGitConfig", "lua EditGitConfig()", {})
vim.api.nvim_create_user_command("Docs", "lua Docs()", { desc = "Wyszukiwarka plików dokumentacji nvim-qfjz"})
vim.api.nvim_create_user_command("LastMsg", "lua require('noice').cmd('last')", { desc = "Wyświetla ostatnie komunikaty"})
vim.api.nvim_create_user_command("HistoryMsg", "lua require('noice').cmd('history')", { desc = "Wyświetla historię komunikatów"})
vim.api.nvim_create_user_command("Light", "colorscheme tokyonight-day", { desc = "Zmienia kolor na jasny"})
vim.api.nvim_create_user_command("Dark", "colorscheme tokyonight-moon", { desc = "Zmienia kolor na ciemny"})
vim.api.nvim_create_user_command("RevBackground", "lua RevBackground()", { desc = ""})
vim.api.nvim_create_user_command("Time", "lua Time()", { desc = ""})
vim.api.nvim_create_user_command("CopyFileName", "lua CopyFileName()", { desc = ""})
vim.api.nvim_create_user_command("GetSpell", "lua GetSpell()", { desc = ""})
vim.api.nvim_create_user_command("GA", "lua GA()", { desc = ""})
vim.api.nvim_create_user_command("ClearRegs", "lua ClearRegs()", { desc = ""})

-- https://github.com/justinsgithub/Oh-My-LazyVim/blob/main/lua/_oml/config/commands/init.lua
vim.api.nvim_create_user_command("BiPolar", function(_)
    local moods_table = {
        ["true"] = "false",
        ["false"] = "true",
        ["True"] = "False",
        ["False"] = "True",
        ["on"] = "off",
        ["off"] = "on",
        ["On"] = "Off",
        ["Off"] = "On",
        ["open"] = "close",
        ["close"] = "open",
        ["Open"] = "Close",
        ["Close"] = "Open",
    }
    local cursor_word = vim.api.nvim_eval("expand('<cword>')")
    if moods_table[cursor_word] then
        vim.cmd("normal ciw" .. moods_table[cursor_word] .. "")
    end
end, { desc = "Switch Moody Words", force = true })

-- Otwiera plik pod kursorem dodając na początku ścieśki "src/"
vim.api.nvim_create_user_command("OpenFile", function()
    local cursor_word = "src/" .. vim.api.nvim_eval("expand('<cWORD>')")
    vim.cmd("e " .. cursor_word)
end, { force = true })
