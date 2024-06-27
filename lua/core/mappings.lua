-- mappings
vim.keymap.set("n", [[<s-enter>]], "mzO<esc>`z", { desc = "Dodaje pustą linię powyżej bieżącej" })
vim.keymap.set("n", [[<enter>]], "mzo<esc>`z", { desc = "Dodaje pustą linię poniżej bieżącej" })
-- vim.keymap.set("n", "<enter>", "<cmd>lua Write()<cr>", { desc = "Zapisuje zmiany" })
vim.keymap.set("v", [[<enter>]], "y", { desc = "Kopiuje zaznaczony tekst" })
vim.keymap.set("n", [[<leader>n]], "<cmd>Neotree reveal_force_cwd toggle<cr>", { desc = "Uruchamia menadżer plików NeoTree" })
vim.keymap.set("n", [[\]], "<cmd>Neotree reveal_force_cwd toggle<cr>", { desc = "Uruchamia menadżer plików NeoTree" })
-- vim.keymap.set("n", [[<leader>\]], "<cmd>Neotree source=buffers reveal_force_cwd=true position=right action=focus toggle<cr>", { desc = "NeoTree otwarte bufory" })
vim.keymap.set("n", "<M-f>", require("oil").open, { desc = "Menadżer plików Oil" })
vim.keymap.set("n", "<leader>f", "<cmd>lua Files()<cr>", { desc = "FzfLua files" })
vim.keymap.set({"n", "x"}, [[gh]], "^", { desc = "Początek linii" })
vim.keymap.set({"n", "x"}, [[gl]], "$", { desc = "Koniec linii" })
-- vim.keymap.set({"n", "x" }, "$", "g_", { desc = "Przechodzi do ostatniego drukowalnego znaku w linii" })  -- 
-- vim.keymap.set("n", "H", "0")
-- vim.keymap.set("n", "M", "gM")
-- vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "mm", "<cmd>BookmarksMark<cr>")
vim.keymap.set("n", "mo", "<cmd>BookmarksGoto<cr>")
vim.keymap.set("n", "<leader>B", "<cmd>BiPolar<cr>")
-- vim.keymap.set({"n", "x"}, "H", "0")
-- vim.keymap.set({"n", "x"}, "M", "gM")
-- vim.keymap.set({"n", "x"}, "L", "$")
vim.keymap.set("n", [[<leader>,]], [[<cmd>bp<cr>]], { desc = "Poprzeni bufor" })
vim.keymap.set("n", [[<leader>.]], [[<cmd>bn<cr>]], { desc = "Następny bufor" })
vim.keymap.set("n", [[<leader>w]], [[<cmd>lua Write()<cr>]], { desc = "Zapisanie zmian" })
vim.keymap.set("n", [[<leader>q]], [[<cmd>lua Write()<cr><cmd>q<cr>]], { desc = "Zapisuje zmiany i wychodzi" })
vim.keymap.set("n", [[<leader>W]], [[:w %:p:h/]], { desc = "Zapisuje plik pod wybraną nazwą w bieżącym katalogu" })
vim.keymap.set("n", [[<m-n>]], [[<cmd>enew<cr>]], { desc = "Otwiera pusty bufor" })
vim.keymap.set("n", [[qq]], [[<cmd>qa<cr>]], { desc = "Wyjście" })
vim.keymap.set({"n", "x"}, [[<leader>;]], [[:]], { desc = "Wejście do trybu COMMAND" })
vim.keymap.set("n", [[<c-h>]], [[<c-w><c-h>]], { desc = "Przechodzi do okna po lewej" })
vim.keymap.set("n", [[<c-l>]], [[<c-w><c-l>]], { desc = "Przechodzi do okna po prawej" })
vim.keymap.set("n", [[<c-j>]], [[<c-w><c-j>]], { desc = "Przechodzi do okna niżej" })
vim.keymap.set("n", [[<c-k>]], [[<c-w><c-k>]], { desc = "Przechodzi do okna wyżej" })
-- Mapowanie dla terminala
vim.keymap.set("t", [[<c-h>]], [[<c-\><c-n><c-w>h]])
vim.keymap.set("t", [[<c-j>]], [[<c-\><c-n><c-w>j]])
vim.keymap.set("t", [[<c-k>]], [[<c-\><c-n><c-w>k]])
vim.keymap.set("t", [[<c-l>]], [[<c-\><c-n><c-w>l]])
vim.keymap.set("t", "kj", [[<c-\><c-n>]], { desc = "Przejście do trybu NORMAL w terminalu" } )
-- vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Przejście do trybu NORMAL w terminalu" } )
vim.keymap.set("n", [[<leader>so]], [[<cmd>luafile %<cr><cmd>lua vim.notify("Przeładowałem plik: " .. vim.fn.expand("%:p"))<cr>]], { desc = "Wczytuje bieżący plik Lua" })
vim.keymap.set("n", [[<leader>d]], [[<cmd>bd<cr>]], { desc = "Zamyka bufor" })
vim.keymap.set("n", [[gf]], [[<cmd>edit <cfile><cr>]], { desc = "Otwiera plik pod kursorem" })
vim.keymap.set("n", [[dh]], "xd0", { desc = "Usuwa od kursora do początku linii" })
vim.keymap.set("n", [[dl]], "d$", { desc = "Usuwa od kursora do końca linii" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Pozostawia kursor po łączeniu linii" })
vim.keymap.set("n", "<leader>sv", "<cmd>vs<cr>", { desc = "Dzieli okno w pionie" })
vim.keymap.set("n", "<leader>sp", "<cmd>sp<cr>", { desc = "Dzieli okno w poziomie" })
vim.keymap.set("n", "<leader>v", "<cmd>lua NvimConfig()<cr>", { desc = "Wyszukiwarka plików konfiguracyjnych" })
vim.keymap.set("n", "<leader>?", "<cmd>lua Docs()<cr>", { desc = "Przeszukiwanie lokalnej dokumentacji" })
vim.keymap.set('n', '<leader>N', [[<cmd>norm A<cr><cmd>lua Insert_ID()<cr>]], { noremap = true, silent = true, desc = "Wstawia znacznik" })
vim.keymap.set('n', 'gm', "<cmd>lua GrepNvimHash()<cr>", { noremap = true, silent = true, desc = "Wyszukuje znacznika" })
-- vim.keymap.set({ "n" }, "gm", [[<cmd>lua require("fzf-lua").grep_cWORD({ cwd = "$HOME/.config/nvim/docs" })<cr>]])
vim.keymap.set("n", "yA", "<cmd>%yank<cr>", { desc = "Kopiuje całą zawartość pliku do rejestru" })
vim.keymap.set("n", "dA", "<cmd>%delete<cr>", { desc = "Usuwa całą zawartość pliku" })
vim.keymap.set("n", "gV", "v`[o`]", { desc = "Przechodzi do ostateniego zaznaczenia lub skopiowanego tekstu" })
vim.keymap.set("n", "<space>m", "<cmd>lua CopyReg()<cr>", { desc = "Kopiuje zawartość głównego rejestru do rejestru 'x'" })
vim.keymap.set("n", "M", '"xp', { desc = "Wkleja zawartość rejestru 'x', standardowo klawisz 'M' przenosi kursor na środek ekranu" })
-- vim.keymap.set("n", [[M]], [[`m]], { desc = "Przechodzi do znacznika `m`" })
vim.keymap.set("n", "<leader>C", "<cmd>enew<cr>", { desc = "Tworzy nowy plik" })
vim.keymap.set("n", "<F9>", "<cmd>lua KolorPora()<cr>", { desc = "Zmiana tematu kolorystycznego w zależności od pory dnia" })
vim.keymap.set("n", "<leader><F9>", "<cmd>FzfLua colorschemes<cr>", { desc = "FzfLua colorschemes" })
vim.keymap.set("n", "<c-_>", "<Plug>kommentary_line_default", { desc = "<Ctrl + /> Tworzy komentarz" })
vim.keymap.set("x", "<c-_>", "<Plug>kommentary_visual_default", { desc = "<Ctrl + /> Tworzy komentarz" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Rejestr zmian Undotree" })
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { silent = true, desc = "Zwiększa wartość liczby" })
vim.keymap.set({ "n", "x" }, "-", "<C-x>", { silent = true, desc = "Zmniejsza wartość liczby" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Przełączanie pomiędzy buforami" })
vim.keymap.set("n", [[<s-tab>]], "<cmd>BufferPick<cr>", { desc = "Pozwala wybrać bufor za pomocą jednej litery" })
vim.keymap.set("n", "<leader>BB", function()
    CDFD()
    require("fzf-lua").buffers({ cwd_only = true })
end, { desc = "Pokazuje bufory znajdujące się w bieżącym katalogu co aktualnie otwarty plik" })
vim.keymap.set("n", "<tab>", "<cmd>e #<cr>", { desc= "Przełączanie pomiędzy dwoma ostatnimi buforami" })
vim.keymap.set("n", "<leader>o", "<cmd>only<cr>", { desc = "Pozostawia otwarte tylko aktywne okno" })
vim.keymap.set("n", "<leader>cc", "<cmd>close<cr>", { desc = "Zamyka aktywne okno" })
vim.keymap.set("n", "<esc>", "<cmd>nohl<cr>", { silent = true, desc = "Wyłącza wyróżnianie szukanego tekstu" })
-- vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "<leader>k", "<cmd>lua Komendy()<cr>", { desc = "FzfLua live grep" })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "FzfLua live grep" })
vim.keymap.set("n", "<leader>A", "<cmd>Alpha<cr>", { desc = "Dashboard Alpha" })
vim.keymap.set("n", "<leader>a", "=ip gqap", { desc = "Wyrównanie paragrafu" })
vim.keymap.set("n", "U", "<c-r>", { desc = "Przywraca zmiany" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "<down>", "j<cmd>echo 'Press j'<cr>")
vim.keymap.set("n", "<up>", "k<cmd>echo 'Press k'<cr>")
vim.keymap.set("n", "<left>", "h<cmd>echo 'Press h'<cr>")
vim.keymap.set("n", "<right>", "l<cmd>echo 'Press l'<cr>")
vim.keymap.set("n", "<c-n>", '<cmd>lua require"gitsigns.actions".next_hunk()<cr>zv')
vim.keymap.set("n", "<c-p>", '<cmd>lua require"gitsigns.actions".prev_hunk()<cr>zv')
vim.keymap.set("n", "gj", '<cmd>lua require"gitsigns.actions".next_hunk()<cr>zv', { desc = "Następna zmiana w pliku - Git" })
vim.keymap.set("n", "gk", '<cmd>lua require"gitsigns.actions".prev_hunk()<cr>zv', { silent = true }, { desc = "Poprzednia zmiana w pliku - git" })
vim.keymap.set("n", "<leader>l", "<cmd>lua require('lf').start({ border = 'none', width = vim.o.columns, height = vim.o.lines })<cr>")
vim.keymap.set("n", "vv", "^vg_", { desc = "Zaznacza linię pomijając puste znaki na początku i znak końca linii" })
vim.keymap.set("n", "tt", ":t.<cr>", { desc = "Dublowanie linii" })
vim.keymap.set("n", "<leader>cp", "yap<s-}>p", { desc = "Klonuje cały paragraf" })
vim.keymap.set("n", "vd", [[:norm vj<cr>:sort u<cr>]], { noremap = true, silent = true , desc = "Porównuje linie, jeśli są identyczne usuwa jedną z nich" })
vim.keymap.set("v", "<LeftRelease>", '"+ygv<Esc>', { desc = "Kopiowanie zaznaczonego tekstu myszką" })
vim.keymap.set("n", "<leader>r", '<cmd>FzfLua registers<cr>', { desc = "Wklej z wybranego rejestru" })
-- vim.keymap.set("n", [["]], "<cmd>FzfLua registers<cr>", { desc = "Przeszukiwanie rejestrów" })
vim.keymap.set("x", "<leader>d", [["_d]], { desc = "Usuwa zaznaczony tekst nie kopiując go do standardowego rejestru" })
vim.keymap.set("n", "<leader>yy", "^vg_y", { desc = "Kopiuje linię pomijając puste znaki na początku i znak końca linii" })
-- kokopiujepiuje do schowka systemowego np: <leader>yap - kopiuje paragraf do schowka systemowego
vim.keymap.set("n", "<leader>y", [["*y]], { desc = "Rozpoczyna sekwencję kopiowania (<leader>yap)" })
vim.keymap.set("n", "<leader>Y", [["*y$]], { desc = "Kopiuje od kursora do końca linii" })
vim.keymap.set("x", "<leader>y", [["*y]], { desc = "Kopiuje zaznaczony tekst w trybie VISUAL" })
-- vim.keymap.set("v", "y", "ygv<Esc>", { desc = "Pozostawia zaznaczenie po skopiowaniu, 'gv'" })
-- Wkleja tekst bez końca linii w linii wyżej / linii poniżej,
-- przydatne jeśli kopiujemy tekst ze środka linii lub linię bez znaku końca linii
-- https://gist.github.com/benfrain/97f2b91087121b2d4ba0dcc4202d252f
vim.keymap.set("n", "<leader>P", '<cmd>exe "put! " . v:register<cr>', { desc = "Wklej powyżej" })
vim.keymap.set("n", "<leader>p", '<cmd>exe "put "  . v:register<cr>', { desc = "Wklej poniżej" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Wkleja, nie podmieniając rejestru w trybie VISUAL" })
-- vim.keymap.set("n", "<C-A-v>", "<cmd>pu +<cr>", { desc = "Ctrl + Alt + v - wkleja ze schowka systemowego (+) w trybie NORMAL" })
-- vim.keymap.set("i", "<S-Insert>", "<c-r>+", { desc = "Wklejanie ze schowka systemowego <Shift> + <Insert>" })
-- vim.keymap.set("i", "<S-Insert>", "<cmd>pu +<cr>", { noremap = true })
-- vim.keymap.set("i", "<S-Insert>", "<cmd>pu +<cr>")
-- vim.keymap.set("x", "p", '"_c<Esc>p')  -- Wkleja, nie podmieniając rejestru w trybie VISUAL
-- vim.keymap.set("v", "p", [["_dp]])  -- W trybie VISUAL wkleja tekst bez kopiowania oryginalnego
-- vim.keymap.set("v", "P", [["_dP]])  -- W trybie VISUAL wkleja tekst bez kopiowania oryginalnego
-- Usuwa obiekt tekstowy nie kopiując go do standardowego rejestru
-- Na przykład <leader>xd usuwa całą linię, <leader>xiw usuwa wyraz pod kursorem
vim.keymap.set("n", "<leader>x", [["_d]])
vim.keymap.set("x", "<leader>x", [["_d]])
vim.keymap.set("n", "d<space>", "daw", { desc = "Usuwa wyraz pod kursorem" })  -- #0c9d04f3
-- vim.keymap.set("n", "<leader>x", "<cmd>lua Write()<cr><cmd>q<cr>", { desc = "Zapisuje zmiany i wychodzi" })
vim.keymap.set("n", ",p", '"0p', { desc = "Wkleja ostatnio skopiowany tekst, NIE ten wycięty / usunięty" })
vim.keymap.set("n", ",P", '"0P', { desc = "Wkleja ostatnio skopiowany tekst, NIE ten wycięty / usunięty" })
vim.keymap.set("n", "zn", "zm")
vim.keymap.set("n", "zm", "zn")
vim.keymap.set("n", "<leader>tb", "<cmd>BiPolar<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<leader>te", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>tf", "<cmd>FzfLua<cr>")
vim.keymap.set("n", "<leader>tc", "<cmd>Cheatsheet<cr>")
vim.keymap.set("n", "<leader>tl", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>ti", "<cmd>belowright 10split term://$HOME/bin/gi.sh<cr>", { desc = "Uruchamia w terminalu skrypt gi.sh" })
vim.keymap.set('n', '<leader>ty', [[<cmd>s/\[\s\]/[x]/<cr><cmd>nohl<cr>]], { silent = true , desc = "Checkbox Done"})
vim.keymap.set('n', '<leader>tu', [[<cmd>s/\[x\]/[ ]/<cr><cmd>nohl<cr>]], { silent = true, desc = "Checkbox ToDo" })
-- Zmiana wielkości okna
vim.keymap.set("n", "<m-h>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<m-j>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<m-k>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<m-l>", "<cmd>vertical resize +2<cr>")
vim.keymap.set("n", "<space><space>", "<cmd>lua FindNotesDir()<cr>")
vim.keymap.set("c", "<c-p>", [[<c-r>"]], { desc = "Wkleja w linii komend"})
vim.keymap.set("n", "<leader><cr>", "<cmd>.!bash<cr>", { desc = "Uruchamia komendę z bieżącej linii: echo 2+2 | bc" })
vim.keymap.set("n", "<leader>xx", [["_dd]], { desc = "Usuwa linię, bez kopiowania do rejestru" })
-- Przechodzi do kolejnej / poprzedniej szukanej pozycji, dodatkowo wyśrodkowuje ekran i otwiera zagnieżdżenia
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("v", [[//]], [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], { silent = true, desc = "Wyszukuje zaznaczonego tekstu" })
-- zlicza ilość wystąpień wyrazu pod kursorem
vim.keymap.set("n", "*", "*<C-O>:%s///gn<CR>")
vim.keymap.set("n", "#", function()
    require('fzf-lua').grep_cWORD({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Wyszukuje słowa znajdującego się pod kursorem" })
-- vim.keymap.set("n", "#", "#<C-O>:%s///gn<CR>")
-- Poruszanie się pomiędzy zmianami w pliku
vim.keymap.set("n", "g;", "g;zvzz")
vim.keymap.set("n", "g,", "g,zvzz")
vim.keymap.set("n", "gs", "<cmd>FzfLua spell_suggest<cr>", { desc = "Sugestie sprawdzania pisowni" })
-- poruszanie się po podmenu podpowiedzi <c-y> zatwierdza; <c-e> przerywa
vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
-- Przechodzi ekran w dół / górę jednocześnie wyśrodkowując stronę i otwierając zagnieżdżenia
vim.keymap.set("n", "<c-d>", "<c-d>zzzv")
vim.keymap.set("n", "<c-u>", "<c-u>zzzv")
-- Poruszanie się pomiędzy paragrafami
vim.keymap.set("n", "}", "}zvzz")
vim.keymap.set("n", "{", "{zvzz")
-- TAB w trybie VISUAL pozostaje w trybie VISUAL
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Przenosi zaznaczony tekst linię wyżej" })
vim.keymap.set("x", "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Przenosi zaznaczony tekst linię niżej" })
-- Uruchamia przeglądarkę na linku pod kursorem używając przeglądarki zdefiniowanej w zmiennej $BROWSER
vim.keymap.set("n", "gx", "<cmd>silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>")
-- zaznacza wyraz pod kursorem i przechodzi do modyfikacji wszystkich znalezionych wyrazów
vim.keymap.set("n", "<leader>sc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Znajdź i zamień, wyraz pod kursorem" })
-- w trybie VISUAL ('v') należy zacząć zaznaczanie od słowa, które chcemy zamienić
vim.keymap.set("x", "<leader>sc", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- zamienia wyraz znajdujący się pod kursorem, wcześniej skopiowanym wyrazem, operacja na całym pliku
vim.keymap.set("n", "<leader>S", [[:%s/\<<c-r><c-w>\>/<c-r>0/gI<cr>]])
-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader>L", "<cmd>lua FileInfo()<cr>", { desc = "Wyświetla informacje o pliku" })
-- Historia komend :
vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "q:", "<cmd>FzfLua command_history<cr>")
vim.keymap.set("n", "q;", "<cmd>FzfLua command_history<cr>")
vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
vim.keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
vim.keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
vim.keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)
-- uzupełnianie ścieżki
vim.keymap.set({ "i" }, "<C-x><C-f>",
  function()
    require("fzf-lua").complete_file({
      cmd = "rg --files",
      winopts = { preview = { hidden = "nohidden" } }
    })
  end, { silent = true, desc = "Fuzzy complete file" })
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
vim.keymap.set("n", "<leader>i", function()
    require('fzf-lua').git_status({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Pokazuje zmiany w repozytorium Git" })
vim.keymap.set("n", "<leader>sg", "<cmd>lua GitFiles()<cr>", { desc = "FzfLua git_files" })
vim.keymap.set("n", "<leader>sh", function()
    require('fzf-lua').help_tags({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Przeszukiwanie stron pomocy" })
vim.keymap.set("n", "<leader>s.", function()
    require('fzf-lua').oldfiles({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Wyszukiwanie ostatnio edytowanych plików" })
vim.keymap.set("n", "<leader>sf", function()
    require('fzf-lua').files({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Wyszukiwanie plików" })
vim.keymap.set("n", "<leader>sk", function()
    require('fzf-lua').keymaps({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        },
    })
end, { desc = "Mapowanie klawiszy" })
-- Plugin todo-comments.nvim
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
-- You can also specify a list of valid jump keywords
-- vim.keymap.set("n", "]t", function()
    -- require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })
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
-- vim.keymap.set("n", "<leader>z", "<cmd>q!<cr>", { desc = "Kończy pracę :q!" })
-- Obsługa pluginu vim-surround
vim.keymap.set("n", "<leader>sw", ":norm ysiw", { desc = "Czeka na wprowadzenie znaku, którym otoczy wyraz" })
vim.keymap.set("n", "<leader>sW", ":norm ysiW", { desc = "Czeka na wprowadzenie znaku, którym otoczy WYRAZ" })
vim.keymap.set("n", "<leader>ssp", ":norm ysip", { desc = "Czeka na wprowadzenie znaku, który otoczy paragraf" })
vim.keymap.set("n", "<leader>ss", ":norm yss", { desc = "Czeka na wprowadzenie znaku, którym otoczy linię" })
vim.keymap.set("n", "<leader>sdd", ":norm ds", { desc = "Czeka na wprowadzenie znaku, którym zostanie usunięty" })
vim.keymap.set("n", "<leader>5", "<cmd>!./%<cr>", { desc = "Uruchom skrypt" })
vim.keymap.set("n", "<leader>7", "<cmd>setlocal spell! spell? spelllang=pl<cr>", { desc = "Włącz sprawdzanie pisowni" })
-- Poruszanie się w trybie COMMAND
vim.keymap.set("c", "<c-j>", "<down>")
vim.keymap.set("c", "<c-k>", "<up>")
vim.keymap.set("c", "<c-h>", "<left>")
vim.keymap.set("c", "<c-l>", "<right>")
-- Noice - historia komunikatów
-- vim.keymap.set("n", "<leader>nl", function()
    -- require("noice").cmd("last")
-- end)
-- vim.keymap.set("n", "<leader>nh", function()
    -- require("noice").cmd("history")
-- end)
vim.keymap.set({ "n", "v" }, "<leader>ci", function()
    vim.cmd[[norm "kyy]]
    vim.cmd[[cd $NOTES_DIR]]
    vim.fn.writefile({ "--" }, 'INBOX.md', 'a')
    -- Wstawia nazwę pliku z którego pochodzi skopiowany tekst
    vim.fn.writefile(vim.fn.getreg('%', 1, 1), 'INBOX.md', 'a')
    vim.fn.writefile(vim.fn.getreg('@', 1, 1), 'INBOX.md', 'a')
    vim.cmd[[cd %:p:h]]
end, { desc = "Kopiuje bieżącą linię lub zaznaczenie do pliku $NOTES_DIR/INBOX.md" })
vim.keymap.set({ "n", "v" }, "<leader>si", function()
    vim.cmd[[norm "kdd]]
    vim.cmd[[cd $NOTES_DIR]]
    vim.fn.writefile({ "--" }, 'INBOX.md', 'a')
    -- Wstawia nazwę pliku z którego pochodzi przeniesiony tekst
    vim.fn.writefile(vim.fn.getreg('%', 1, 1), 'INBOX.md', 'a')
    vim.fn.writefile(vim.fn.getreg('@', 1, 1), 'INBOX.md', 'a')
    vim.cmd[[cd %:p:h]]
end, { desc = "Przenosi bieżącą linię lub zaznaczenie do pliku $NOTES_DIR/INBOX.md" })
-- vim.keymap.set("n", "<leader>ef", "<cmd>lua FindNotesDir()<cr>")
-- vim.keymap.set(
    -- "v",
    -- "<leader>sv",
    -- [[:'<,'>d<cr>:lua SendVLineToFile(os.getenv("NOTES_DIR") .. "/INBOX.md")<cr>]]
-- )
-- vim.keymap.set("v", "<leader>sv", function()
    -- vim.cmd("'<,'> d")
    -- SendVLineToFile(os.getenv("NOTES_DIR") .. "/INBOX.md")
-- end)
-- Kopiuje bieżącą linię do pliku $NOTES_DIR/INBOX.md
-- vim.keymap.set("n", "<leader>ci", '<cmd>lua CopyLineToFile(os.getenv("NOTES_DIR") .. "/INBOX.md")<cr>')
-- Kopiuje zaznaczone linie do pliku $NOTES_DIR/INBOX.md
--[[ vim.keymap.set(
  "x",
  "<leader>ci",
  ":'<,'>y<cr>:cd $NOTES_DIR<cr>:call writefile(getreg('@', 1, 1), 'INBOX.md', 'a')<cr>:cd %:p:h<cr>"
) ]]
-- Przenosi bieżącą linię do $NOTES_DIR/INBOX.md
--[[ vim.keymap.set(
  "n",
  "<leader>si",
  '<cmd>lua SendLineToFile(os.getenv("NOTES_DIR") .. "/INBOX.md")<cr>'
) ]]
-- Przenosi zaznaczone linie do pliku $NOTES_DIR/INBOX.md
--[[ vim.keymap.set(
  "x",
  "<leader>si",
  ":'<,'>d<cr>:cd $notes_dir<cr>:call writefile(getreg('@', 1, 1), 'inbox.md', 'a')<cr>:cd %:p:h<cr>"
) ]]
-- edycja pliku $notes_dir/inbox.md
-- vim.keymap.set("n", "<leader>ei", ":e $notes_dir/inbox.md<cr>")
-- Wyszukiwanie plików w katalogu $NOTES_DIR
-- vim.keymap.set("n", "<leader>ee", "<cmd>lua FindNotesDir()<cr>")
-- Przeszukiwanie plików w katalogu $NOTES_DIR
-- vim.keymap.set("n", "<leader>er", "<cmd>lua GrepNotesDir()<cr>")
-- Kopiowanie przez SSH
-- local function copy(lines, _)
--   require('osc52').copy(table.concat(lines, '\n'))
-- end
-- 
-- local function paste()
--   return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
-- end
-- 
-- vim.g.clipboard = {
--   name = 'osc52',
--   copy = {['+'] = copy, ['*'] = copy},
--   paste = {['+'] = paste, ['*'] = paste},
-- }
-- 
-- -- Now the '+' register will copy to system clipboard using OSC52
-- vim.keymap.set('n', '<leader>c', '"+y')
-- vim.keymap.set('n', '<leader>cc', '"+yy')
