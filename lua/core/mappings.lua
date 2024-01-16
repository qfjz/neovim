vim.keymap.set("n", [[<s-enter>]], "mzO<esc>`z", { desc = "Dodaje pustą linię powyżej bieżącej" })
vim.keymap.set("n", [[<enter>]], "mzo<esc>`z", { desc = "Dodaje pustą linię poniżej bieżącej" })
vim.keymap.set("n", [[<leader>n]], "<cmd>Neotree reveal_force_cwd toggle<cr>", { desc = "Uruchamia menadżer plików NeoTree" })
vim.keymap.set("n", [[\]], "<cmd>Neotree reveal_force_cwd toggle<cr>", { desc = "Uruchamia menadżer plików NeoTree" })
vim.keymap.set({"n", "x"}, [[gh]], "^", { desc = "Początek linii" })
vim.keymap.set({"n", "x"}, [[gl]], "$", { desc = "Koniec linii" })
vim.keymap.set("n", [[<leader>,]], [[<cmd>bp<cr>]], { desc = "Poprzeni bufor" })
vim.keymap.set("n", [[<leader>.]], [[<cmd>bn<cr>]], { desc = "Następny bufor" })
vim.keymap.set("n", [[<leader>w]], [[<cmd>lua Write()<cr>]], { desc = "Zapisanie zmian" })
vim.keymap.set("n", [[qq]], [[<cmd>qa<cr>]], { desc = "Wyjśćie" })
vim.keymap.set({"n", "x"}, [[<leader>;]], [[:]], { desc = "Wejście do trybu COMMAND" })
vim.keymap.set("n", [[<c-h>]], [[<c-w><c-h>]], { desc = "Przechodzi do okna po lewej" })
vim.keymap.set("n", [[<c-l>]], [[<c-w><c-l>]], { desc = "Przechodzi do okna po prawej" })
vim.keymap.set("n", [[<c-j>]], [[<c-w><c-j>]], { desc = "Przechodzi do okna niżej" })
vim.keymap.set("n", [[<c-k>]], [[<c-w><c-k>]], { desc = "Przechodzi do okna wyżej" })
vim.keymap.set("n", [[<leader>so]], [[<cmd>luafile %<cr><cmd>lua vim.notify("Przeładowałem plik: " .. vim.fn.expand("%:p"))<cr>]], { desc = "Wczytuje bieżący plik Lua" })
vim.keymap.set("n", [[<leader>d]], [[<cmd>bd<cr>]], { desc = "Usuwa bufor" })
vim.keymap.set("n", [[gf]], [[<cmd>edit <cfile><cr>]], { desc = "Otwiera plik pod kursorem" })
vim.keymap.set("n", [[dh]], "xd0", { desc = "Usuwa od kursora do początku linii" })
vim.keymap.set("n", [[dl]], "d$", { desc = "Usuwa od kursora do końca linii" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Pozostawia kursor po łączeniu linii" })
vim.keymap.set("n", "<leader>sv", "<cmd>vs<cr>", { desc = "Dzieli okno w pionie" })
vim.keymap.set("n", "<leader>sp", "<cmd>sp<cr>", { desc = "Dzieli okno w poziomie" })
vim.keymap.set("n", "<leader>v", "<cmd>lua NvimConfig()<cr>", { desc = "Wyszukiwarka plików konfiguracyjnych" })
vim.keymap.set("n", "yA", "<cmd>%yank<cr>", { desc = "Kopiuje całą zawartość pliku do rejestru" })
vim.keymap.set("n", "<space>m", "<cmd>lua CopyReg()<cr>", { desc = "Kopiuje zawartość głównego rejestru do rejestru 'x'" })
vim.keymap.set("n", "M", '"xp', { desc = "Wkleja zawartość rejestru 'x', standardowo klawisz 'M' przenosi kursor na środek ekranu" })
-- vim.keymap.set("n", [[M]], [[`m]], { desc = "Przechodzi do znacznika `m`" })
vim.keymap.set("n", "<leader>C", "<cmd>enew<cr>", { desc = "Tworzy nowy plik" })
vim.keymap.set("n", "<F9>", "<cmd>lua KolorPora()<cr>", { desc = "Zmiana tematu kolorystycznego w zależności od pory dnia" })
vim.keymap.set("n", "<c-_>", "<Plug>kommentary_line_default", { desc = "<Ctrl + /> Tworzy komentarz" })
vim.keymap.set("x", "<c-_>", "<Plug>kommentary_visual_default", { desc = "<Ctrl + /> Tworzy komentarz" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Rejestr zmian Undotree" })
vim.keymap.set("n", "+", "<C-a>", { desc = "Zwiększa wartość liczby" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Zmniejsza wartość liczby" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Przełączanie pomiędzy buforami" })
vim.keymap.set("n", "<tab>", "<cmd>e #<cr>", { desc= "Przełączanie pomiędzy dwoma ostatnimi buforami" })
vim.keymap.set("n", [[<s-tab>]], "<cmd>BufferPick<cr>", { desc = "Pozwala wybrać bufor za pomocą jednej litery" })
vim.keymap.set("n", "<leader>o", "<cmd>only<cr>", { desc = "Pozostawia otwarte tylko aktywne okno" })
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>", { desc = "Zamyka aktywne okno" })
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { silent = true, desc = "Wyłącza wyróżnianie szukanego tekstu" })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "FzfLua live grep" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "FzfLua files" })
vim.keymap.set("n", "U", "<c-r>", { desc = "Przywraca zmiany" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "gj", '<cmd>lua require"gitsigns.actions".next_hunk()<cr>zv', { desc = "Następna zmiana w pliku - Git" })
vim.keymap.set("n", "gk", '<cmd>lua require"gitsigns.actions".prev_hunk()<cr>zv', { silent = true }, { desc = "Poprzednia zmiana w pliku - git" })
vim.keymap.set("n", "<leader>l", "<cmd>lua require('lf').start({ border = 'none', width = vim.o.columns, height = vim.o.lines })<cr>")
vim.keymap.set("n", "vv", "^vg_", { desc = "Zaznacza linię pomijając puste znaki na początku i znak końca linii" })
vim.keymap.set("n", "tt", ":t.<cr>", { desc = "Dublowanie linii" })
vim.keymap.set("n", "<leader>cp", "yap<s-}>p", { desc = "Klonuje cały paragraf" })
vim.keymap.set("n", "vd", [[:norm vj<cr>:sort u<cr>]], { noremap = true, silent = true , desc = "Sprawdza czy kolejna linia jest identyczna, jeśli tak usuwa jedną z nich" })
vim.keymap.set("n", "<leader>r", '<cmd>FzfLua registers<cr>', { desc = "Wklej z wybranego rejestru" })
vim.keymap.set("n", "<leader>yy", "^vg_y", { desc = "Kopiuje linię pomijając puste znaki na początku i znak końca linii" })
-- kokopiujepiuje do schowka systemowego np: <leader>yap - kopiuje paragraf do schowka systemowego
vim.keymap.set("n", "<leader>y", [["*y]], { desc = "Rozpoczyna sekwencję kopiowania (<leader>yap)" })
vim.keymap.set("n", "<leader>Y", [["*y$]], { desc = "Kopiuje od kursora do końca linii" })
vim.keymap.set("x", "<leader>y", [["*y]], { desc = "Kopiuje zaznaczony tekst w trybie VISUAL" })
-- Wkleja tekst bez końca linii w linii wyżej / linii poniżej przydatne jeśli kopiujemy tekst ze środka linii lub linię bez znaku końca linii
-- https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
vim.keymap.set("n", "<leader>P", '<cmd>exe "put! " . v:register<cr>', { desc = "Wklej powyżej" })
vim.keymap.set("n", "<leader>p", '<cmd>exe "put "  . v:register<cr>', { desc = "Wklej poniżej" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Wkleja, nie podmieniając rejestru w trybie VISUAL" })
-- Usuwa obiekt tekstowy nie kopiując go do standardowego rejestru
-- Na przykład <leader>xd usuwa całą linię, <leader>xiw usuwa wyraz pod kursorem
vim.keymap.set("n", "<leader>x", [["_d]])
vim.keymap.set("x", "<leader>x", [["_d]])
vim.keymap.set("n", "<leader>xx", [["_dd]], { desc = "Usuwa linię, bez kopiowania do rejestru" })
vim.keymap.set("n", ",p", '"0p', { desc = "Wkleja ostatnio skopiowany tekst, NIE ten wycięty / usunięty" })
vim.keymap.set("n", ",P", '"0P', { desc = "Wkleja ostatnio skopiowany tekst, NIE ten wycięty / usunięty" })
vim.keymap.set("n", "zn", "zm")
vim.keymap.set("n", "zm", "zn")
-- Zmiana wielkości okna
vim.keymap.set("n", "<m-h>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<m-j>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<m-k>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<m-l>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<space><space>", "<cmd>lua FindNotesDir()<cr>")
-- Wklejanie w linii komend
vim.keymap.set("c", "<c-r>p", '<c-r>"')
-- Mapowanie znaczników (undo) w trybie INSERT, po wprowadzeniu jednego ze znaków , . ! ? ; :
local undo_ch = { ",", ".", "!", "?", ";", ":" }
for _, ch in ipairs(undo_ch) do
    vim.keymap.set("i", ch, ch .. "<c-g>u")
end
-- Plugin flash.nvim wyszukiwanie za pomocą "s"
vim.keymap.set({ "n", "o", "x" }, "s", function()
    require("flash").jump({
        search = {
            -- forward = true,
            wrap = true,
            multi_window = false,
            -- wyszukuje tylko początku wyrazu
            mode = function(str)
                return "\\<" .. str
            end,
        },
    })
end)
-- ZenMode
vim.keymap.set("n", "<leader>z", function()
    if vim.g.zen_mode_active then
        require("zen-mode").toggle()
        vim.g.zen_mode_active = false
        vim.cmd[[IBLToggle]]
    else
        require("zen-mode").toggle()
        vim.g.zen_mode_active = true
        vim.cmd[[IBLToggle]]
    end
end, { desc = "Zen Mode Toggle" })
-- Noice
--[[ vim.keymap.set("n", "<leader>nl", function()
  require("noice").cmd("last")
end)
vim.keymap.set("n", "<leader>nh", function()
  require("noice").cmd("history")
end) ]]
