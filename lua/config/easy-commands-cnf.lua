require("easy-commands").setup({
    disabledCommands = { "CopyFilename" },

    aliases = {
        { from = "HistoryMsg", to = "Messages" },
        { from = "F", to = "Files" },
        { from = "GitFiles", to = "GFiles" },
    },

    ---@type EasyCommand.Command[]
    myCommands = {
        {
            name = "BrowsingAllMarks",
            callback = function()
                local api = require("bookmarks.api")
                local picker = require("bookmarks.adapter.picker")
                picker.pick_bookmark(function(bookmark)
                    api.goto_bookmark(bookmark, { open_method = "vsplit" })
                end, { all = true })
            end,
        },
        {
            name = "CommandLineHistory",
            callback = 'FzfLua command_history',
        },
        {
            name = "SearchHistory",
            callback = "FzfLua search_history"
        },
        {
            name = "Kolory",
            callback = "FzfLua colorschemes"
        },
        {
            name = "GitStatus",
            callback = "lua require'fzf-lua'.git_status({ winopts = { height=1, width=1 } })"
        },
        {
            name = "Keymaps",
            callback = "FzfLua keymaps",
            description = "Wyszukiwarka skrótów klawiszowych",
        },
        {
            name = "List",
            callback = "set list!",
        },
        {
            name = "Wrap",
            callback = function()
                vim.cmd[[set wrap!]]
                vim.notify(vim.cmd[[set wrap?]], { timeout = 6000 })
            end,
        },
        {
            name = "ShowMiddleDot",
            callback = "lua vim.opt.listchars:append('space:·')"
        },
        {
            name = "HideMiddleDot",
            callback = "lua vim.opt.listchars:remove('space')",
        },
        {
            name = "OldFiles",
            callback = "FzfLua oldfiles",
            description = "Ostatnio edytowane pliki",
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
            name = "KolorPora",
            callback = "lua KolorPora()",
        },
        {
            name = "CDFD",
            callback = "lua CDFD()",
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
            name = "CDG",
            callback = "lua CDG()",
        },
        {
            name = "GI",
            callback = "lua GI()",
        },
        {
            name = "F",
            callback = "lua Files()",
        },
        {
            name = "GitFiles",
            callback = "lua GitFiles()",
        },
        {
            name = "NvimAppName",
            callback = "lua vim.notify(NvimAppName())",
        },
        {
            name = "Config",
            callback = "lua NvimConfig()",
            description = "Wyszukiwarka plików konfiguracyjnych Neovim",
        },
        {
            name = "DesFree",
            callback = "lua DesFree()",
        },
        {
            name = "EditBmDirs",
            callback = "lua EditBmDirs()",
        },
        {
            name = "Skroty",
            callback = "lua Skroty()",
        },
        {
            name = "Fileinfo",
            callback = "lua FileInfo()",
        },
        {
            name = "PU",
            callback = "lua PU()",
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
            name = "TermGitStatus",
            callback = "lua require'toggleterm'.exec('git status', 1, 22)",
        },
        {
            name = "OstatniaAktualizacja",
            callback = "lua OstatniaAktualizacja()",
        },
        {
            name = "TermGitPull",
            callback = "lua require'toggleterm'.exec('git pull', 1, 12)",
        },
        {
            name = "TermPs",
            callback = "lua require'toggleterm'.exec('ps ax', 1, 12)",
        },
        {
            name = "BmFiles",
            callback = "lua BmFiles()",
        },
        {
            name = "AddBmFile",
            callback = "lua AddBMFile()",
        },
        {
            name = "EditBmFiles",
            callback = "lua EditBmFiles()",
        },
        {
            name = "BufInfo",
            callback = "lua BufInfo()",
        },
        {
            name = "EditGitConfig",
            callback = "lua EditGitConfig()",
        },
        {
            name = "Docs",
            callback = "lua Docs()",
            description = "Wyszukiwarka plików dokumentacji nvim-qfjz"
        },
        {
            name = "LastMsg",
            callback = "lua require('noice').cmd('last')",
        },
        {
            name = "HistoryMsg",
            callback = "lua require('noice').cmd('history')",
        },
        {
            name = "Light",
            callback = "colorscheme tokyonight-day",
        },
        {
            name = "Dark",
            callback = "colorscheme tokyonight-moon",
        },
        {
            name = "RevBackground",
            callback = "lua RevBackground()",
        },
        {
            name = "Time",
            callback = "lua Time()",
        },
        {
            name = "CopyFileName",
            callback = "lua CopyFileName()",
        },
        {
            name = "GetSpell",
            callback = "lua GetSpell()",
        },
        {
            name = "GA",
            callback = "lua GA()",
            description = "",
        },
        {
            name = "ClearRegs",
            callback = "lua ClearRegs()",
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
            -- Otwiera plik pod kursorem dodając na początku ścieśki "src/"
            name = "OpenFile",
            callback = function()
                local cursor_word = "src/" .. vim.api.nvim_eval("expand('<cWORD>')")
                vim.cmd("e " .. cursor_word)
            end, { force = true }
        },
    },
})
