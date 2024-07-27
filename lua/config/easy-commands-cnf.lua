require("easy-commands").setup({
    disabledCommands = { "CopyFilename" },

    aliases = {
        { from = "HistoryMsg", to = "Messages" },
        { from = "F", to = "Files" },
        { from = "GitFiles", to = "GFiles" },
        { from = "EditCDDirs", to = "EditBmDirs" },
    },

    ---@type EasyCommand.Command[]
    myCommands = {
        {
            name = "AddBmFile",
            callback = "lua AddBmFile()",
        },
        {
            name = "AddCDDir",
            callback = "lua AddCDDir()",
        },
        {
            name = "BackupNeovimConfig",
            callback = "TermExec cmd='$HOME/bin/neovim-config-backup.sh " .. NvimAppName() .. "'",
        },
        {
            -- https://github.com/justinsgithub/Oh-My-LazyVim/blob/main/lua/_oml/config/commands/init.lua
            name = "BiPolar",
            callback = function(_)
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
            end, { desc = "Switch Moody Words", force = true },
        },
        {
            name = "BmFiles",
            callback = "lua BmFiles()",
        },
        {
            name = "BookmarksAllMarks",
            callback = function()
                local api = require("bookmarks.api")
                local picker = require("bookmarks.adapter.picker")
                picker.pick_bookmark(function(bookmark)
                    api.goto_bookmark(bookmark, { open_method = "vsplit" })
                end, { all = true })
            end,
        },
        {
            name = "BookmarksDelete",
            callback = function()
                local repo = require("bookmarks.repo")
                local picker = require("bookmarks.adapter.picker")
                picker.pick_bookmark(function(bookmark)
                    repo.mark.write.delete(bookmark)
                end)
            end,
        },
        {
            name = "BufInfo",
            callback = "lua BufInfo()",
        },
        {
            name = "CD",
            callback = "lua CD()",
        },
        {
            name = "CDE",
            callback = "lua CDE()",
        },
        {
            name = "CDFD",
            callback = "lua CDFD()",
        },
        {
            name = "CDG",
            callback = "lua CDG()",
        },
        {
            name = "ClearRegs",
            callback = "lua ClearRegs()",
        },
        {
            name = "CommandLineHistory",
            callback = 'FzfLua command_history',
        },
        {
            name = "Config",
            callback = "lua NvimConfig()",
            description = "Wyszukiwarka plików konfiguracyjnych Neovim",
        },
        {
            name = "CopyFileName",
            callback = "lua CopyFileName()",
        },
        {
            name = "Dark",
            callback = "colorscheme tokyonight-moon",
        },
        {
            name = "DesFree",
            callback = "lua DesFree()",
        },
        {
            name = "Docs",
            callback = "lua Docs()",
            description = "Wyszukiwarka plików dokumentacji nvim-qfjz"
        },
        {
            name = "EditCDDirs",
            callback = "lua EditCDDirs()",
        },
        {
            name = "EditBmFiles",
            callback = "lua EditBmFiles()",
        },
        {
            name = "F",
            callback = "lua Files()",
        },
        {
            name = "EditGitConfig",
            callback = "lua EditGitConfig()",
        },
        {
            name = "InsertDate",
            callback = "lua InsertDate()"
        },
        {
            name = "InsertEPOCH",
            callback = "lua InsertEPOCH()"
        },
        {
            name = "InsertID",
            callback = "lua Insert_ID()"
        },
        {
            name = "Fileinfo",
            callback = "lua FileInfo()",
        },
        {
            name = "GA",
            callback = "lua GA()",
            description = "",
        },
        {
            name = "GetSpell",
            callback = "lua GetSpell()",
        },
        {
            name = "GI",
            callback = "lua GI()",
        },
        {
            name = "GitFiles",
            callback = "lua GitFiles()",
        },
        {
            name = "GitStatus",
            callback = "lua require'fzf-lua'.git_status({ winopts = { height=1, width=1 } })"
        },
        {
            name = "GP",
            callback = "lua GP()",
        },
        {
            name = "GPS",
            callback = "lua GPS()",
        },
        {
            name = "HideMiddleDot",
            callback = "lua vim.opt.listchars:remove('space')",
        },
        {
            name = "HistoryMsg",
            callback = "lua require('noice').cmd('history')",
        },
        {
            name = "Hostname",
            callback = function()
                vim.notify(vim.fn.system("hostname"))
            end,
        },
        {
            name = "InsObsdianRemminder",
            callback = "lua InsObsdianRemminder()"
        },
        {
            name = "Keymaps",
            callback = "FzfLua keymaps",
            description = "Wyszukiwarka skrótów klawiszowych",
        },
        {
            name = "KolorPora",
            callback = "lua KolorPora()",
        },
        {
            name = "Kolory",
            callback = "FzfLua colorschemes"
        },
        {
            name = "LastMsg",
            callback = "lua require('noice').cmd('last')",
        },
        {
            name = "Light",
            callback = "colorscheme tokyonight-day",
        },
        {
            name = "List",
            callback = "set list!",
        },
        {
            name = "NeorgHome",
            callback = "Neorg workspace home",
        },
        {
            name = "NeorgWork",
            callback = "Neorg workspace work",
        },
        {
            name = "NewFileNoSplit",
            callback = function()
                vim.cmd[[enew]]
                vim.cmd[[startinsert]]
            end,
        },
        {
            name = "NewFileHSplit",
            callback = function()
                vim.cmd[[new]]
                vim.cmd[[startinsert]]
            end,
        },
        {
            name = "NewFileVSplit",
            callback = function()
                vim.cmd[[vnew]]
                vim.cmd[[startinsert]]
            end,
        },
        {
            name = "NvimAppName",
            callback = "lua vim.notify(NvimAppName())",
        },
        {
            name = "OldFiles",
            callback = "FzfLua oldfiles",
            description = "Ostatnio edytowane pliki",
        },
        {
            -- DESC: Otwiera plik pod kursorem dodając na początku ścieśki "src/"
            name = "OpenFile",
            callback = function()
                local cursor_word = "src/" .. vim.api.nvim_eval("expand('<cWORD>')")
                vim.cmd("e " .. cursor_word)
            end, { force = true }
        },
        {
            name = "OstatniaAktualizacja",
            callback = "lua OstatniaAktualizacja()",
        },
        {
            name = "OstatniaSesja",
            callback = "lua OstatniaSesja()",
        },
        {
            name = "PU",
            callback = "lua PU()",
        },
        {
            name = "RevBackground",
            callback = "lua RevBackground()",
        },
        {
            name = "SearchHistory",
            callback = "FzfLua search_history"
        },
        {
            name = "ShowMiddleDot",
            callback = "lua vim.opt.listchars:append('space:·')"
        },
        {
            name = "Skroty",
            callback = "lua Skroty()",
        },
        {
            name = "TermGitPull",
            callback = "lua require'toggleterm'.exec('git pull', 1, 12)",
        },
        {
            name = "TermGitStatus",
            callback = "lua require'toggleterm'.exec('git status', 1, 22)",
        },
        {
            name = "TermPs",
            callback = "lua require'toggleterm'.exec('ps ax', 1, 12)",
        },
        {
            name = "Time",
            callback = "lua Time()",
        },
        {
            name = "Wrap",
            callback = function()
                vim.cmd[[set wrap!]]
                vim.notify(vim.cmd[[set wrap?]], { timeout = 6000 })
            end,
        },
    },
})
