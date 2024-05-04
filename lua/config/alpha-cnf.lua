-- plugin-alpha.lua
local ok, alpha = pcall(require, 'alpha')
if not ok then return end

local dashboard = require("alpha.themes.dashboard")
local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/" .. NvimAppName() .. "/lazy", "*", 0, 1))
-- dashboard.section.header.val = { "-~= Neovim :•: QFJZ =~-" }
dashboard.section.header.val = {}
dashboard.section.buttons.val = {
    dashboard.button("n", "  Nowy plik", ":enew<cr>"),
    dashboard.button(".", "  Ostatino używane pliki", "<cmd>FzfLua oldfiles<cr>"),
    dashboard.button("s", "  Ostatnia sesja", "<cmd>lua require('persistence').load({ last = true })<cr>"),
    dashboard.button("f", "  Wyszukiwanie plików", "<cmd>FzfLua files<cr>"),
    dashboard.button("g", "  Przeszukiwanie plików", "<cmd>FzfLua live_grep<cr>"),
    dashboard.button("b", "  Skrypty ~/bin", "<cmd>lua SearchDir('$HOME/bin')<cr>"),
    dashboard.button("v", "  Konfiguracja Neovim", "<cmd>lua NvimConfig()<cr>"),
    dashboard.button("K", "  Kolory", "<cmd>Kolory<cr>"),
    dashboard.button("d", "  Dokumentacja", "<cmd>lua Docs()<cr>"),
    dashboard.button("u", "  Aktualizacja pluginów", "<cmd>Lazy update<cr>"),
    dashboard.button("q", "  Exit", "<cmd>qa!<cr>"),
}
dashboard.section.footer.val = "liczba  ~ " .. plugins_count
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
