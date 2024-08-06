local M = {}

M.komendy = function()
    local lista_komend = {
        "AddBmFile - dodaj plik do ulubionych",
        "AddCDDir - dodaj katalog do ulubionych",
        "Alpha Dashboard",
        "CDGitRoot - przechodzi do katalogu głównego repozytorium Git",
        "Cheatsheet QFJZ Edit",
        "Cheatsheet QFJZ",
        "Dodaj Modeline",
        "Dodaj pliki do repozytorium Git (GA)",
        "Dodaje, podpisuje i wysyła pliki do repozytorium Git (GPS)",
        "Edytuj plik konfiguracyjny repozytorium Git .git/config (EditGitConfig)",
        "Edytuj ulubione katalogi ~/.config/bmdirs (EditCDDirs)",
        "Edytuj ulubione pliki ~/.config/bmfiles (EditBmFiles)",
        "Exit",
        "FileNeovimDocs",
        "FindGitRoot",
        "Force Quit - wyjdź bez zapisywania",
        "GitStatus",
        "GP - dodaje i wysyła pliki do repozytorium Git",
        "GrepGitRoot",
        "GrepNeovimDocs",
        "Informacje o buforze (BufInfo)",
        "Instalacja nowych pluginów (Lazy install)",
        "Kopiuj bieżącą linię do wybranego pliku (CopyLineToSelectedFile)",
        "Kopiuj zaznaczone linie do wybranego pliku (CopyVLineToSelectedFile)",
        "Kopiuje katalog nazwę pliku do rejestru (CopyFileName)",
        "Lazy update - aktualizacja pluginów",
        "Menadżer plików Neotree",
        "Menadżer plików Oil.nvim",
        "Neorg przejdź do workspace home",
        "Neorg przejdź do workspace work",
        "OpenFile",
        "OstatniaAktualizacja - aktualizacja lini 'Aktualizacja: '",
        "Otwórz katalog wybrany z (CDE)",
        "Otwórz nowy plik (NewFileNoSplit)",
        "Otwórz nowy plik w podziale pionowym (NewFileVSplit)",
        "Otwórz nowy plik w podziale poziomym (NewFileHSplit)",
        "Pobierz zmiany z repozytorium Git w terminalu (TermGitPull)",
        "Pobierze słownik pisowni języka polskiego (GetSpell)",
        "Pokazuje zmiany w repozytorium Git (FzfLua git_status)",
        "Pokazuje znak · wstawiony w miejsce spacji (ShowMiddleDot)",
        "Pokaż główny katalog repozytorium Git (CDG)",
        "Pokaż Timer (TimerShow)",
        "Przejdź do katalogu dla otwartego pliku (CDFD)",
        "Przejdź do katalogu wybranego z ulubionych (CD)",
        "Przeszukiwanie historii wyszukiwania (FzfLua search_history)",
        "Przeszukiwanie katalogu $NOTES_DIR (GrepNotesDir)",
        "Przeszukiwanie listy quick fix (FzfLua quickfix)",
        "Przeszukiwanie location list (FzfLua loclist)",
        "Przywróc ostatnią sesję (OstatniaSesja)",
        "PU - pobiera zmiany z repozytorium Git",
        "Reload user module",
        "Skopiuj całą zawartość pliku",
        "Sortuj bufory według numerów (BufferOrderByBufferNumber)",
        "Sprawdza czy w systemie są wymagane programy (CheckExternalReqs)",
        "Time - Pokaż datę i godzinę (Time)",
        "Ukryj Timer (TimerHide)",
        "Ukrywa znak · wstawiony w miejsce spacji (HideMiddleDot)",
        "Ulubione katalogi (BmDirs i CD)",
        "Ulubione pliki (BmFiles)",
        "Ustaw jasny schemat kolorystyczny (Light)",
        "Ustaw schemat kolorystyczny na tokyonight-moon (Dark)",
        "Ustaw scrolloff na 3",
        "Ustaw scrolloff na 999",
        "Ustaw Timer na 1 minutę (TimerStart 1m)",
        "Ustaw Timer na 15 minut (TimerStart 15m)",
        "Ustaw Timer na 30 minut (TimerStart 30m)",
        "Ustaw Timer na 5 minut (TimerStart 5m)",
        "Ustaw Timer na 60 minut (TimerStart 60m)",
        "Ustawia przezroczystość dla Neovide na 0.2",
        "Ustawia przezroczystość dla Neovide na 1",
        "Usunięcie nieużywanych pluginów (Lazy clean)",
        "Usuwanie zakładek (BookmarksDelete)",
        "Usuń bieżący plik z systemu plików",
        "Usuń całą zawartość pliku",
        "Usuń wszystkie puste linie oraz linie wypełnione znakiem spacji w pliku",
        "Usuń wszystkie puste linie w pliku",
        "Write & Quit - zapisz i wyjdź",
        "Write - zapisz zmiany",
        "Wstaw aktualną datę i godzinę w formacie 2024-07-22 17:28:27",
        "Wstaw znacznik czasu EPOCH",
        "Wstaw znacznik ID",
        "Wstawia znacznik dla przypomnień w programie Obsidian (InsObsdianReminder)",
        "Wybierz bufor (BufferPick)",
        "Wyczyść wszystkie rejestry (ClearRegs)",
        "Wykonaj kopię zapasową plików Neovim (BackupNeovimConfig)",
        "Wyszukaj znacznik ID",
        "Wyszukiwanie komend (FzfLua commands)",
        "Wyszukiwanie notatek (FindNotesDir)",
        "Wyszukiwanie ostatnio edytowanych plików (FzfLua oldfiles)",
        "Wyszukiwanie plików konfiguracyjnych Neovim w katalogu $NVIM_APPNAME (Config)",
        "Wyszukiwanie plików w bieżącej lokalizacji (Files)",
        "Wyszukiwanie pomocy Neovim (FzfLua helptags)",
        "Wyszukiwanie skrótów klawiszowych (FzfLua keymaps)",
        "Wyszukiwanie zakładek (BookmarksAllMarks)",
        "Wyszukiwarka rejestrów",
        "Wyszukuje pliki znajdujące się w repozytorium Git (GitFiles)",
        "Wyłącz autopairs",
        "Wyłącz wszystkie dekoracje (DesFree)",
        "Wyłącza prowadnice wcięć (IBLDisable)",
        "Wyświetl procesy systemowe (TermPs)",
        "Wyświetl zmiany w repozytorium Git w terminalu (TermGitStatus)",
        "Wyświetl znacznik czasu EPOCH w czytelnej formie daty",
        "Wyświetla / ukrywa dekoratory list (List)",
        "Wyświetla historię komend (CommandLineHistory)",
        "Wyświetla informacje o otwartym pliku (FileInfo)",
        "Wyświetla informacje o repozytorium (GI)",
        "Wyświetla komunikaty (Messages)",
        "Wyświetla nazwę systemu (Hostname)",
        "Wyświetla nazwę zmiennej NVIM_APPNAME",
        "Wyświetla ostatni komunikat (LastMsg)",
        "Wyświetla wersję programu Neovim (CheckVersion)",
        "Włącz / wyłącz numerowanie wierszy (number!)",
        "Włącz / wyłącz relatywne numerowanie wierszy (set relativenumber!)",
        "Włącz / wyłącz tryb ZenMode",
        "Włącz / wyłącz zawijanie linii (Wrap)",
        "Włącz autopairs",
        "Włącz sprawdzanie pisowni (spell)",
        "Włącza / wyłącza prowadnice wcięć (IBLToggle)",
        "Włącza prowadnice wcięć (IBLEnable)",
        "Zamiana popularnych słów true / false (BiPolar)",
        "Zamienia koniec linii EOL na CRLF (DOS)",
        "Zamienia koniec linii EOL na LF (Unix)",
        "Zamknij aktywny bufor",
        "Zamknij wszystkie bufory poza aktywnym (BufferCloseAllButCurrent)",
        "Zatrzymaj Timer (TimerStop)",
        "Zmiana języka Neovim na język angielski (language en_US)",
        "Zmiana języka Neovim na język polski (language pl_PL.UTF-8)",
        "Zmiana schematu kolorystycznego (Kolory)",
        "Zmiana znacznika czasu EPOCH na czytelną formę daty",
        "Zmienia rozmiar czcionki dla Neovide na 12",
        "Zmienia rozmiar czcionki dla Neovide na 17",
        "Zmienia rozmiar czcionki dla Neovide na 21",
        "Zmienia schemat kolorystyczny biorąc pod uwagę porę dnia (KolorPora)",
        "Zmień kolorystyke Jasny / Ciemny (RevBackground)",
    }
    local opts = {}
    opts.prompt = " Wyszukaj > "
    opts.winopts = { title = " Komendy " }
    opts.actions = {
        ["default"] = function(selected)
            local choice = selected[1]
            if choice == "AddBmFile - dodaj plik do ulubionych" then
                require("user_functions.bookmarks").AddBmFile()
            elseif choice == "Wybierz bufor (BufferPick)" then
                vim.cmd[[BufferPick]]
            elseif choice == "GrepGitRoot" then
                require("user_functions.misc").GrepGitRoot()
            elseif choice == "FindGitRoot" then
                require("user_functions.misc").FindGitRoot()
            elseif choice == "CDGitRoot - przechodzi do katalogu głównego repozytorium Git" then
                require("user_functions.misc").CDGitRoot()
            elseif choice == "OpenFile" then
                local cursor_word = "src/" .. vim.api.nvim_eval("expand('<cWORD>')")
                vim.cmd("e " .. cursor_word)
            elseif choice == "Wyszukiwarka rejestrów" then
                vim.cmd[[FzfLua registers]]
            elseif choice == "Alpha Dashboard" then
                vim.cmd[[Alpha]]
            elseif choice == "GrepGitRoot" then
                require("user_functions.misc").GrepGitRoot()
            elseif choice == "Edytuj ulubione pliki ~/.config/bmfiles (EditBmFiles)" then
                require("user_functions.bookmarks").EditBmFiles()
            elseif choice == "FileNeovimDocs" then
                require("user_functions.misc").FindFilesDir("/usr/share/nvim/runtime/doc/")
            elseif choice == "GrepNeovimDocs" then
                require("user_functions.misc").GrepDirectory("/usr/share/nvim/runtime/doc/")
            elseif choice == "AddCDDir - dodaj katalog do ulubionych" then
                require("user_functions.bookmarks").AddCDDir()
            elseif choice == "Wykonaj kopię zapasową plików Neovim (BackupNeovimConfig)" then
                vim.cmd("TermExec cmd='$HOME/bin/neovim-config-backup.sh " .. require("user_functions.misc").NvimAppName() .. "'")
            elseif choice == "Zamiana popularnych słów true / false (BiPolar)" then
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
            elseif choice == "Ulubione pliki (BmFiles)" then
                require("user_functions.bookmarks").BmFiles()
            elseif choice == "Exit" then
                vim.cmd.wa()
                vim.cmd.qa()
            elseif choice == "Pobierze słownik pisowni języka polskiego (GetSpell)" then
                require("user_functions.misc").GetSpell()
            elseif choice == "Ulubione katalogi (BmDirs i CD)" then
                require("user_functions.bookmarks").CD()
            elseif choice == "Ustaw Timer na 1 minutę (TimerStart 1m)" then
                vim.cmd[[TimerStart 1m]]
            elseif choice == "Ustaw Timer na 5 minut (TimerStart 5m)" then
                vim.cmd[[TimerStart 5m]]
            elseif choice == "Ustaw Timer na 15 minut (TimerStart 15m)" then
                vim.cmd[[TimerStart 15m]]
            elseif choice == "Ustaw Timer na 30 minut (TimerStart 30m)" then
                vim.cmd[[TimerStart 30m]]
            elseif choice == "Ustaw Timer na 60 minut (TimerStart 60m)" then
                vim.cmd[[TimerStart 60m]]
            elseif choice == "Zatrzymaj Timer (TimerStop)" then
                vim.cmd[[TimerStop]]
            elseif choice == "GitStatus" then
                vim.cmd("lua require'fzf-lua'.git_status({ winopts = { height=1, width=1 } })")
            elseif choice == "Informacje o buforze (BufInfo)" then
                require("user_functions.misc").BufInfo()
            elseif choice == "Wyszukiwanie zakładek (BookmarksAllMarks)" then
                local api = require("bookmarks.api")
                local picker = require("bookmarks.adapter.picker")
                picker.pick_bookmark(function(bookmark)
                    api.goto_bookmark(bookmark, { open_method = "vsplit" })
                end, { all = true })
            elseif choice == "Usuwanie zakładek (BookmarksDelete)" then
                local repo = require("bookmarks.repo")
                local picker = require("bookmarks.adapter.picker")
                picker.pick_bookmark(function(bookmark)
                    repo.mark.write.delete(bookmark)
                end)
            elseif choice == "Zamknij wszystkie bufory poza aktywnym (BufferCloseAllButCurrent)" then
                vim.cmd[[BufferCloseAllButCurrent]]
            elseif choice == "Sortuj bufory według numerów (BufferOrderByBufferNumber)" then
                vim.cmd[[BufferOrderByBufferNumber]]
            elseif choice == "Przejdź do katalogu wybranego z ulubionych (CD)" then
                require("user_functions.bookmarks").CD()
            elseif choice == "Otwórz katalog wybrany z (CDE)" then
                require("user_functions.bookmarks").CDE()
            elseif choice == "Przejdź do katalogu dla otwartego pliku (CDFD)" then
                require("user_functions.misc").CDFD()
            elseif choice == "Wyczyść wszystkie rejestry (ClearRegs)" then
                require("user_functions.misc").ClearRegs()
            elseif choice == "Wyświetla historię komend (CommandLineHistory)" then
                vim.cmd[[CommandLineHistory]]
            elseif choice == "Wyszukiwanie plików konfiguracyjnych Neovim w katalogu $NVIM_APPNAME (Config)" then
                require("user_functions.misc").NvimConfig()
            elseif choice == "Pokaż główny katalog repozytorium Git (CDG)" then
                require("user_functions.git").CDG()
            elseif choice == "Kopiuje katalog nazwę pliku do rejestru (CopyFileName)" then
                require("user_functions.misc").CopyFileName()
            elseif choice == "Ustaw schemat kolorystyczny na tokyonight-moon (Dark)" then
                vim.cmd[[colorscheme tokyonight-moon]]
            elseif choice == "Wyłącz wszystkie dekoracje (DesFree)" then
                require("user_functions.misc").DesFree()
            elseif choice == "Edytuj ulubione katalogi ~/.config/bmdirs (EditCDDirs)" then
                require("user_functions.bookmarks").EditCDDirs()
            elseif choice == "Edytuj plik konfiguracyjny repozytorium Git .git/config (EditGitConfig)" then
                require("user_functions.git").EditGitConfig()
            elseif choice == "Wyświetla informacje o otwartym pliku (FileInfo)" then
                require("user_functions.misc").FileInfo()
            elseif choice == "Wyszukiwanie plików w bieżącej lokalizacji (Files)" then
                require("user_functions.misc").Files()
            elseif choice == "Wyszukiwanie komend (FzfLua commands)" then
                vim.cmd[[FzfLua commands]]
            elseif choice == "Wyszukiwanie pomocy Neovim (FzfLua helptags)" then
                vim.cmd[[FzfLua helptags]]
            elseif choice == "Wyszukiwanie skrótów klawiszowych (FzfLua keymaps)" then
                vim.cmd[[FzfLua keymaps]]
            elseif choice == "Wyszukiwanie ostatnio edytowanych plików (FzfLua oldfiles)" then
                require("user_functions.misc").OldFiles()
            elseif choice == "Przeszukiwanie historii wyszukiwania (FzfLua search_history)" then
                vim.cmd[[FzfLua search_history]]
            elseif choice == "Dodaj pliki do repozytorium Git (GA)" then
                require("user_functions.git").GA()
            elseif choice == "Wyświetla informacje o repozytorium (GI)" then
                require("user_functions.git").GI()
            elseif choice == "Wyszukuje pliki znajdujące się w repozytorium Git (GitFiles)" then
                require("user_functions.misc").GitFiles()
            elseif choice == "Pokazuje zmiany w repozytorium Git (FzfLua git_status)" then
                vim.cmd[[FzfLua git_status]]
            elseif choice == "GP - dodaje i wysyła pliki do repozytorium Git" then
                require("user_functions.git").GP()
            elseif choice == "Dodaje, podpisuje i wysyła pliki do repozytorium Git (GPS)" then
                require("user_functions.git").GPS()
            elseif choice == "PU - pobiera zmiany z repozytorium Git" then
                require("user_functions.git").PU()
            elseif choice == "Ukrywa znak · wstawiony w miejsce spacji (HideMiddleDot)" then
                vim.cmd("lua vim.opt.listchars:remove('space')")
            elseif choice == "Pokazuje znak · wstawiony w miejsce spacji (ShowMiddleDot)" then
                vim.cmd("lua vim.opt.listchars:append('space:·')")
            elseif choice == "Wyświetla nazwę systemu (Hostname)" then
                vim.notify(vim.fn.system('hostname'))
            elseif choice == "Wyłącza prowadnice wcięć (IBLDisable)" then
                vim.cmd[[IBLDisable]]
            elseif choice == "Włącza prowadnice wcięć (IBLEnable)" then
                vim.cmd[[IBLEnable]]
            elseif choice == "Włącza / wyłącza prowadnice wcięć (IBLToggle)" then
                vim.cmd[[IBLToggle]]
            elseif choice == "Wstawia znacznik dla przypomnień w programie Obsidian (InsObsdianReminder)" then
                require("user_functions.notatki").InsObsdianReminder()
            elseif choice == "Zmienia schemat kolorystyczny biorąc pod uwagę porę dnia (KolorPora)" then
                require("user_functions.misc").KolorPora()
            elseif choice == "Zmiana schematu kolorystycznego (Kolory)" then
                vim.cmd[[FzfLua colorschemes]]
            elseif choice == "Zmiana języka Neovim na język angielski (language en_US)" then
                vim.cmd[[language en_US]]
            elseif choice == "Zmiana języka Neovim na język polski (language pl_PL.UTF-8)" then
                vim.cmd[[language pl_PL.UTF-8]]
            elseif choice == "Lazy update - aktualizacja pluginów" then
                vim.cmd[[Lazy clean]]
            elseif choice == "Instalacja nowych pluginów (Lazy install)" then
                vim.cmd[[Lazy install]]
            elseif choice == "Aktualizacja pluginów (Lazy update)" then
                vim.cmd[[Lazy update]]
            elseif choice == "Ustaw jasny schemat kolorystyczny (Light)" then
                vim.cmd[[colorscheme tokyonight-day]]
            elseif choice == "Wyświetla / ukrywa dekoratory list (List)" then
                vim.cmd[[set list!]]
            elseif choice == "Sprawdza czy w systemie są wymagane programy (CheckExternalReqs)" then
                require("user_functions.misc").CheckExternalReqs()
            elseif choice == "Wyświetla wersję programu Neovim (CheckVersion)" then
                require("user_functions.misc").CheckVersion()
            elseif choice == "Ustawia przezroczystość dla Neovide na 0.2" then
                vim.cmd[[lua vim.g.neovide_transparency = 0.2]]
            elseif choice == "Ustawia przezroczystość dla Neovide na 1" then
                vim.cmd[[lua vim.g.neovide_transparency = 1]]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 12" then
                vim.cmd[[lua vim.o.guifont = "Source Code Pro:h12"]]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 17" then
                vim.cmd[[lua vim.o.guifont = "Source Code Pro:h17"]]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 21" then
                vim.cmd[[lua vim.o.guifont = "Source Code Pro:h21"]]
            elseif choice == "Wyświetla komunikaty (Messages)" then
                vim.cmd("lua require('noice').cmd('history')")
            elseif choice == "Wyświetla ostatni komunikat (LastMsg)" then
                vim.cmd("lua require('noice').cmd('last')")
            elseif choice == "Ukryj Timer (TimerHide)" then
                vim.cmd[[TimerHide]]
            elseif choice == "Pokaż Timer (TimerShow)" then
                vim.cmd[[TimerShow]]
            elseif choice == "Neorg przejdź do workspace home" then
                vim.cmd[[Neorg workspace home]]
            elseif choice == "Neorg przejdź do workspace work" then
                vim.cmd[[Neorg workspace work]]
            elseif choice == "Otwórz nowy plik w podziale poziomym (NewFileHSplit)" then
                vim.cmd[[new]]
                vim.cmd[[startinsert]]
            elseif choice == "Otwórz nowy plik w podziale pionowym (NewFileVSplit)" then
                vim.cmd[[vnew]]
                vim.cmd[[startinsert]]
            elseif choice == "Otwórz nowy plik (NewFileNoSplit)" then
                vim.cmd[[enew]]
                vim.cmd[[startinsert]]
            elseif choice == "Wyświetla nazwę zmiennej NVIM_APPNAME" then
                print(require("user_functions.misc").NvimAppName())
            elseif choice == "OstatniaAktualizacja - aktualizacja lini 'Aktualizacja: '" then
                require("user_functions.misc").OstatniaAktualizacja()
            elseif choice == "Przywróc ostatnią sesję (OstatniaSesja)" then
                require("user_functions.misc").OstatniaSesja()
            elseif choice == "Włącz / wyłącz numerowanie wierszy (number!)" then
                vim.cmd[[set number!]]
            elseif choice == "Włącz / wyłącz relatywne numerowanie wierszy (set relativenumber!)" then
                vim.cmd[[set relativenumber!]]
            elseif choice == "Włącz sprawdzanie pisowni (spell)" then
                vim.cmd[[setlocal spell! spell? spelllang=pl]]
            elseif choice == "Pobierz zmiany z repozytorium Git w terminalu (TermGitPull)" then
                vim.cmd("lua require'toggleterm'.exec('git pull', 1, 12)")
            elseif choice == "Wyświetl zmiany w repozytorium Git w terminalu (TermGitStatus)" then
                vim.cmd[[lua require'toggleterm'.exec('git status', 1, 22)]]
            elseif choice == "Zmień kolorystyke Jasny / Ciemny (RevBackground)" then
                vim.cmd[[lua require("user_functions.misc").RevBackground()]]
            elseif choice == "Wyświetl procesy systemowe (TermPs)" then
                vim.cmd("lua require'toggleterm'.exec('ps ax', 1, 12)")
            elseif choice == "Time - Pokaż datę i godzinę (Time)" then
                require("user_functions.misc").Time()
            elseif choice == "Włącz / wyłącz zawijanie linii (Wrap)" then
                vim.cmd[[set wrap!]]
                vim.notify(vim.cmd[[set wrap?]], { timeout = 6000 })
            elseif choice == "Włącz / wyłącz tryb ZenMode" then
                vim.cmd[[ZenMode]]
            elseif choice == "Write - zapisz zmiany" then
                require("user_functions.write").write_file()
            elseif choice == "Write & Quit - zapisz i wyjdź" then
                require("user_functions.write").write_file()
                vim.cmd[[q]]
            elseif choice == "Force Quit - wyjdź bez zapisywania" then
                vim.cmd[[qa!]]
            elseif choice == "Menadżer plików Neotree" then
                vim.cmd[[Neotree reveal_force_cwd toggle]]
            elseif choice == "Menadżer plików Oil.nvim" then
                vim.cmd[[Oil]]
            elseif choice == "Zamknij aktywny bufor" then
                vim.cmd[[bdelete]]
            elseif choice == "Usuń bieżący plik z systemu plików" then
                vim.cmd[[Delete!]]
            elseif choice == "Usuń wszystkie puste linie w pliku" then
                vim.cmd[[g/^$/d]]
            elseif choice == "Usuń wszystkie puste linie oraz linie wypełnione znakiem spacji w pliku" then
                vim.cmd[[g/^\s*$/d]]
            elseif choice == "Zmiana znacznika czasu EPOCH na czytelną formę daty" then
                require("user_functions.misc").EPOCH2Date()
            elseif choice == "Wyświetl znacznik czasu EPOCH w czytelnej formie daty" then
                require("user_functions.misc").EPOCH2DatePrint()
            elseif choice == "Wstaw znacznik czasu EPOCH" then
                require("user_functions.misc").InsertEPOCH()
            elseif choice == "Wstaw aktualną datę i godzinę w formacie 2024-07-22 17:28:27" then
                require("user_functions.misc").InsertDate()
            elseif choice == "Wstaw znacznik ID" then
                require("user_functions.misc").Insert_ID()
            elseif choice == "Wyszukaj znacznik ID" then
                require("user_functions.misc").GrepNvimHash()
            elseif choice == "Skopiuj całą zawartość pliku" then
                vim.cmd[[%yank]]
            elseif choice == "Usuń całą zawartość pliku" then
                vim.cmd[[%delete]]
            elseif choice == "Wyłącz autopairs" then
                require("nvim-autopairs").disable()
            elseif choice == "Włącz autopairs" then
                require("nvim-autopairs").enable()
            elseif choice == "Przeszukiwanie listy quick fix (FzfLua quickfix)" then
                vim.cmd[[FzfLua quickfix]]
            elseif choice == "Kopiuj bieżącą linię do wybranego pliku (CopyLineToSelectedFile)" then
                require("user_functions.notatki").CopyLineToSelectedFile()
            elseif choice == "Kopiuj zaznaczone linie do wybranego pliku (CopyVLineToSelectedFile)" then
                require("user_functions.notatki").CopyVLineToSelectedFile()
            elseif choice == "Wyszukiwanie notatek (FindNotesDir)" then
                require("user_functions.notatki").FindNotesDir()
            elseif choice ==  "Przeszukiwanie location list (FzfLua loclist)" then
                vim.cmd[[FzfLua loclist]]
            elseif choice == "Przeszukiwanie katalogu $NOTES_DIR (GrepNotesDir)" then
                require("user_functions.notatki").GrepNotesDir()
            elseif choice == "Ustaw scrolloff na 3" then
                vim.cmd[[set scrolloff=3]]
            elseif choice == "Ustaw scrolloff na 999" then
                vim.cmd[[set scrolloff=999]]
            elseif choice == "Zamienia koniec linii EOL na CRLF (DOS)" then
                vim.cmd[[set ff=dos]]
            elseif choice == "Zamienia koniec linii EOL na LF (Unix)" then
                vim.cmd[[set ff=unix]]
            elseif choice == "Dodaj Modeline" then
                require("user_functions.misc").Modeline()
            elseif choice == "Cheatsheet QFJZ" then
                vim.cmd[[Cheatsheet]]
            elseif choice == "Cheatsheet QFJZ Edit" then
                vim.cmd[[CheatsheetEdit]]
            elseif choice == "Reload user module" then
                local misc = require("user_functions.misc")
                local filename = vim.fn.expand("%:t:r")
                local pakiet_user_functions = "user_functions." .. filename
                misc.reload_user_module(pakiet_user_functions)
            end
        end
    }
    require"fzf-lua".fzf_exec(lista_komend, opts)
end

return M
