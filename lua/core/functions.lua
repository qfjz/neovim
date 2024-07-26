-- functions.lua
-- DESC: Dodaje edytowany plik do bmfiles
AddBmFile = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfiles"))
    end
    local BmFilesHandle = io.open(BmFiles, "a+")
    local FileName = vim.fn.resolve(vim.fn.expand("%:p"))
    if BmFilesHandle ~= nil then
        BmFilesHandle:write(FileName .. "\n")
        BmFilesHandle:close()
    else
        vim.notify("Brak pliku " .. BmFiles)
    end
end

-- DESC: Dodaje bieżący katalog do pliku bmdirs
AddCDDir = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    local filename = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
    local directory = vim.fs.dirname(filename)
    if directory == nil then
        print("Plik nie ma swojego miejsca na dysku")
        return
    end
    local BmDirsHandle = io.open(BmDirs, "a+")
    if BmDirsHandle ~= nil then
        BmDirsHandle:write(directory .. "\n")
        BmDirsHandle:close()
    else
        vim.notify("Brak pliku " .. BmDirs)
    end
end

BmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfiles"))
    end
    if vim.fn.filereadable(BmFiles) == 0 then
        io.open(BmFiles, "a+")
    end
    local files = vim.fn.readfile(vim.fn.expand(BmFiles))
    local opts = {}
    opts.prompt = "Files> "
    opts.actions = {
        ['default'] = function(selected)
            vim.cmd("e " .. selected[1])
        end
    }
    require'fzf-lua'.fzf_exec(files, opts)
end

BufInfo = function()
    for _, v in ipairs(vim.fn.getbufinfo("%")) do
        P(v)
    end
    vim.cmd[[Messages]]
end

-- DESC: Standardowo zmienna $BM_DIRS zaweira nazwę pliku w której znajdują się często odwiedzane katalogi
--Zazwyaczaj jest to plik `$HOME/.config/bmdirs`.
CD = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    if vim.fn.filereadable(BmDirs) == 0 then
        io.open(BmDirs, "a+")
    end
    local command = 'cd'
    local opts = {}
    opts.prompt = "CD> "
    opts.actions = {
        ['default'] = function(selected)
            -- wywołanie komendy na wybranym katalogu
            vim.cmd(command .. " " .. selected[1])
        end
    }
    local files = vim.fn.readfile(vim.fn.expand(BmDirs))
    require'fzf-lua'.fzf_exec(files, opts)
end

-- DESC: Otwiera menadżer plików w wybranej lokalizacji
CDE = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    if vim.fn.filereadable(BmDirs) == 0 then
        io.open(BmDirs, "a+")
    end
    local command = 'e'
    local opts = {}
    opts.prompt = "CDE> "
    opts.actions = {
        ['default'] = function(selected)
            -- wywołanie komendy na wybranym katalogu
            vim.cmd(command .. " " .. selected[1])
        end
    }
    local files = vim.fn.readfile(vim.fn.expand(BmDirs))
    require'fzf-lua'.fzf_exec(files, opts)
end

-- DESC: Funkcja przechodzi do katalogu w którym znajduje się edytorwany plik, potrafi podążać za linkami symbolicznymi
CDFD = function()
    local filename = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
    local directory = vim.fs.dirname(filename)
    if directory == nil then
        print("Plik nie ma swojego miejsca na dysku")
        return
    end
    local pwd_dir = vim.fn.system[[pwd]]
    local pwd_dir_trim = vim.trim(pwd_dir)
    if pwd_dir_trim == directory then
        local pwd = vim.fn.system[[pwd]]
        vim.notify(pwd, "info", { timeout = 6000 })
        return
    else
        vim.cmd("cd " .. directory)
        vim.notify(directory, "info", { timeout = 6000 })
    end
end

-- DESC: Funkcja wyświetla główny katalog repozytorium Git
CDG = function()
    if package.loaded['gitsigns'] then
        local root_dir = vim.inspect(vim.fn.getbufinfo("%")[1].variables.gitsigns_status_dict.root)
        local MSG = ("Found git repository at" .. " " .. root_dir)
        vim.notify(MSG, "info", {
            timeout = 6000,
            title = "Informacje o repozytorium",
        })
    else
        local result = vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 and result:find("true") then
            local root_dir = vim.fn.system("git rev-parse --show-toplevel")
            local MSG = ("Found git repository at" .. " " .. root_dir)
            vim.notify(MSG, "info", {
                timeout = 6000,
                title = "Informacje o repozytorium",
            })
        end
    end
end

-- DESC: Sprawdza czy w systemie są zainstalowane wymagane programy
CheckExternalReqs = function()
    for _, exe in ipairs { 'git', 'make', 'unzip', 'rg', 'fzf' } do
        local is_executable = vim.fn.executable(exe) == 1
        if is_executable then
            MSG = string.format("Found executable: '%s'", exe)
            vim.notify(MSG, "info", {
                timeout = 6000,
                -- title = "",
            })
        else
            MSG = string.format("Could not find executable: '%s'", exe)
            vim.notify(MSG, "error", {
                timeout = 6000,
                -- title = "",
            })
        end
    end
  return true
end

CheckVersion = function()
    local verstr = string.format('%s.%s.%s', vim.version().major, vim.version().minor, vim.version().patch)
    if not vim.version.cmp then
        vim.notify(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
        return
    end
    if vim.version.cmp(vim.version(), { 0, 9, 4 }) >= 0 then
        vim.notify(string.format("Neovim version is: '%s'", verstr))
    else
        vim.notify(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    end
end

ClearRegs = function()
    local str = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
    local regs = {}
    for i = 1, #str do
        regs[i] = str:sub(i, i)
    end
    for _, v in ipairs(regs) do
        vim.fn.setreg(v, '')
    end
end

CopyFileName = function()
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    vim.fn.setreg([[*]], Filename, 1)
    -- vim.fn.setreg([[+]], Filename, 1)
end

-- DESC: Kopiuje linię do podanego pliku w argumencie
CopyLineToFile = function(plik)
    vim.cmd("y")
    -- vim.cmd("cd $NOTES_DIR")
    vim.fn.writefile(vim.fn.getreg("@", 1, 1), plik, "a")
    vim.cmd("cd %:p:h")
end

CopyLineToSelectedFile = function()
    local notes_dir = os.getenv("NOTES_DIR")
    if notes_dir == nil then
        notes_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local pliki_scan = vim.fn.system("rg --files -g '*.md' " .. notes_dir)
    local pliki_notatek = vim.fn.substitute(pliki_scan, '\n$', '', '')  -- usunięcie ostatniej pustej linii w tablicy
    local pliki_notatek_table = vim.split(pliki_notatek, " ")
    local opts = {}
    opts.prompt = "Wybierz plik> "
    opts.actions = {
        ['default'] = function(selected)
            local plik = selected[1]
            vim.cmd("y")
            vim.fn.writefile(vim.fn.getreg("@", 1, 1), vim.fn.resolve(vim.fn.expand(plik)), "a")
            vim.cmd("cd %:p:h")
        end
    }
    require'fzf-lua'.fzf_exec(pliki_notatek_table, opts)
end

CopyVLineToSelectedFile = function()
    local notes_dir = os.getenv("NOTES_DIR")
    if notes_dir == nil then
        notes_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local pliki_scan = vim.fn.system("rg --files -g '*.md' " .. notes_dir)
    local pliki_notatek = vim.fn.substitute(pliki_scan, '\n$', '', '')  -- usunięcie ostatniej pustej linii w tablicy
    local pliki_notatek_table = vim.split(pliki_notatek, " ")
    local opts = {}
    opts.prompt = "Wybierz plik> "
    opts.actions = {
        ['default'] = function(selected)
            local plik = selected[1]
            vim.cmd("'<,'>y")
            vim.fn.writefile(vim.fn.getreg("@", 1, 1), vim.fn.resolve(vim.fn.expand(plik)), "a")
            vim.cmd("cd %:p:h")
        end
    }
    require'fzf-lua'.fzf_exec(pliki_notatek_table, opts)
end

-- DESC: kopiuje zawartość standardowego rejestru " do rejestru x
CopyReg = function()
    vim.fn.setreg("x", vim.fn.getreg('"'))
    vim.notify("Skopiowałem standardowy rejestr do rejestru 'x'")
end

-- DESC: Kopiuje linię do podanego pliku w argumencie
CopyVLineToFile = function(plik)
    -- vim.cmd("'<,'>y")
    vim.cmd("y")
    -- vim.cmd("cd $NOTES_DIR")
    vim.fn.writefile(vim.fn.getreg("@", 1, 1), plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Wstawia w miejscu kursora datę w formacie '# 26.07.23'
Date = function()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("o", "n", true)
end

-- DESC: Wstawia: "# 2023-07-23 10:15:13, #29, niedziela 23" lipca w miejscu kursora
DateHeader = function()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "# " .. os.date("%F %T, #%W, %A %d %B") .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("o", "n", true)
    vim.cmd[[silent! language en_US]]
end

DestractionFree = 0
DesFree = function()
    if DestractionFree == 0 then
        DestractionFree = 1
        vim.opt.number = false
        vim.opt.relativenumber = false
        vim.opt.cursorline = false
        vim.opt.colorcolumn = "0"
        vim.opt.signcolumn = "no"
        vim.opt.foldcolumn = "0"
        vim.opt.list = false
    elseif DestractionFree == 1 then
        DestractionFree = 0
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.cursorline = true
        vim.opt.colorcolumn = "+1"
        vim.opt.signcolumn = "yes"
        vim.opt.foldcolumn = "1"
        vim.opt.list = true
    end
    vim.cmd[[IBLToggle]]
end

-- DESC: Wyszukiwanie plików w katalogu docs
Docs = function()
    local rg_cmd = "rg --files --follow -g '*.md'"
    local cwd_dir = "$HOME/.config/" .. NvimAppName() .. "/doc"
    local prompt = "Docs> "
    require'fzf-lua'.files({
        prompt = prompt,
        cwd = cwd_dir,
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

-- DESC: Edycja pliku bmfiles
EditBmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfiles"))
    end
    vim.cmd('e' .. BmFiles)
end

-- DESC: Edycja pliku bmdirs
EditCDDirs = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    vim.cmd('e' .. BmDirs)
end

EditGitConfig = function()
    local git_config_dir = vim.fn.getbufinfo("%")[1].variables.gitsigns_status_dict.gitdir
    vim.cmd("e" .. git_config_dir .. "/config")
end

-- DESC: Wyświetla informacje o pliku
FileInfo = function()
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    Msg=""
    Msg=Msg .. "Mod: " .. vim.fn.strftime("%F %T",vim.fn.getftime(Filename)) .. " " .. Filename .. ", Size: " ..  FileSize() .. ", TL# " .. TotalLines()
    vim.notify(Msg, "info", {
        timeout = 6000,
        title = "Informacje o pliku",
    })
end

-- DESC: Uruchamia FzfLua files
Files = function()
    CDFD()
    local rg_cmd = "rg --files --hidden --follow"
    require'fzf-lua'.files({
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

-- DESC: Przeszukiwanie ostation edytowanych plików
OldFiles = function()
    require'fzf-lua'.oldfiles({
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

-- DESC: Wyszukuje plików w przekazanym jako parametr katalogu
FindFilesDir = function(dir)
    require'fzf-lua'.files({
        prompt="FFD> ",
        cwd = dir,
        cmd = "rg --files --hidden --follow -g  !.git",
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

FileSize = function()
    local file = vim.fn.resolve(vim.fn.expand("%:p"))
    local size = vim.fn.getfsize(file)
    if size <= 0 then
        return ""
    end
    local sufixes = { "b", "k", "m", "g" }
    local i = 1
    while size > 1024 do
        size = size / 1024
        i = i + 1
    end
    return string.format("%.1f%s", size, sufixes[i])
end

FindNotesDir = function()
    local rg_cmd = "rg --files --follow -g '*.md' -g '*.norg'"
    local cwd_dir = os.getenv("NOTES_DIR")
    if cwd_dir == nil then
        cwd_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local prompt = "Notatki> "
    require'fzf-lua'.files({
        prompt = prompt,
        cmd = rg_cmd,
        cwd = cwd_dir,
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

GA = function ()
    CDFD()
    local DateTime = vim.fn.strftime("%F %T")
    vim.cmd("Git add -A")
    vim.cmd("silent! Git commit -m '" .. DateTime .. "'")
end

-- DESC: Generuje losowy ciąg znaków w formacie "-- #xxxx-xxxx"
-- https://vi.stackexchange.com/questions/39681/how-to-insert-text-from-lua-function-at-cursor-position-insert-mode
Generate_ID = function()
    math.randomseed(os.time())
    local random = math.random
    local template = "-- #xxxx-xxxx"
    return string.gsub(template, "x", function()
      local v = random(0, 0xf)  -- v is a decimal number 0 to 15
      return string.format("%x", v) --formatted as a hex number
    end)
end

-- DESC: Sprawdza rozszerzenie pliku podanego w argumencie: lua GetFileExtension('%')
GetFileExtension = function(file)
    -- local file = file
    if vim.fn.fnamemodify(vim.fn.expand(file), ":e") == 'md' then
        print(vim.fn.fnamemodify(file, ":e"))
        print("To jest plik Markdown")
    elseif vim.fn.fnamemodify(vim.fn.expand(file), ":e") == 'lua' then
        print(vim.fn.fnamemodify(file, ":e"))
        print("To jest plik Lua")
    else
        print(vim.fn.fnamemodify(file, ":e"))
        print("Nie wiem co to za plik")
    end 
end

GetSpell = function()
    vim.cmd("!$HOME/bin/get-spell-pl.sh")
end

GI = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GI_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gi.sh"
    local l = vim.fn.system(GI_SH .. " " .. "vim")
    local l_subs = vim.fn.substitute(l, '\n$', '', '')
    vim.notify(l_subs, "info", {
        timeout = 6000,
        title = "Informacje o repozytorium",
    })
end

-- DESC: Uruchamia FzfLua git_files
-- W sytuacji kiedy jesteśmy w repozytorium Git wyszukiwane są wyłącznie pliki dodane do repozytorium!!!
GitFiles = function()
    CDFD()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 and result:find("true") then
        local prompt = "GitFiles> "
        require'fzf-lua'.git_files({
            prompt = prompt,
            winopts = {
                preview = { hidden = "nohidden" },
                fullscreen = true,
            }
        })
    else
        local rg_cmd = "rg --files --hidden --follow"
        require'fzf-lua'.files({
            cmd = rg_cmd,
            winopts = {
                preview = { hidden = "nohidden" },
                fullscreen = true,
            }
        })
    end
end

-- DESC: Uruchamia skrypt `sh/gp.sh`
GP = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GP_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gp.sh"
    vim.fn.system({GP_SH, '-v', '-f %:p'})
    vim.cmd("redraw!")
end

GPS = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GPS_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gps.sh"
    vim.fn.system({GPS_SH, '-v', '-f %:p'})
    vim.cmd("redraw!")
end

-- DESC: Przeszukuje katalog $NOTES_DIR
GrepNotesDir = function()
    local rg_cmd = "rg --line-number --column -g '*.md' -g '*.norg'"
    local notes_dir = os.getenv("NOTES_DIR")
    require'fzf-lua'.live_grep({ prompt = notes_dir .. "> ", cmd = rg_cmd, cwd = notes_dir })
end

-- DESC: Przeszukuje katalog $HOME/.config/NVIM_APPNAME z plikami *.lua dla funkcji GrepNvimHash
GrepNvimConfigDir = function(opts)
    local cwd_dir = "$HOME/.config/" .. NvimAppName()
    local prompt = "Config> "
    local rg_cmd = "rg --line-number --column -g '*.lua'"
    require'fzf-lua'.grep_cWORD({ prompt = prompt, cmd = rg_cmd, cwd = cwd_dir })
end

-- DESC: Przeszukuje katalog $HOME/.config/NVIM_APPNAME/doc z plikami *.md dla funkcji GrepNvimHash
GrepNvimDocsDir = function(opts)
    local cwd_dir = "$HOME/.config/" .. NvimAppName() .. "/doc"
    local prompt = "Docs> "
    local rg_cmd = "rg --line-number --column -g '*.md'"
    require'fzf-lua'.grep_cWORD({ prompt = prompt, cmd = rg_cmd, cwd = cwd_dir })
end

-- DESC: W zależności od pliku w którym się znajdumemy lua/md uruchamia odpowiednią dla niego funkcję
GrepNvimHash = function()
    if vim.bo.filetype == "lua" then
        -- przeszukiwanie katalgou doc
        GrepNvimDocsDir()
    elseif vim.bo.filetype == "markdown" then
        -- przeszukiwanie katalogu ~/.config/nvim/*.lua
        GrepNvimConfigDir()
    end
end

-- DESC: Przeszukuje katalog $HOME/.config/NVIM_APPNAME/doc z plikami *.md
GrepNvimDocs = function()
    local cwd_dir = "$HOME/.config/" .. NvimAppName() .. "/doc"
    local prompt = "Docs> "
    local rg_cmd = "rg --line-number --column -g '*.md'"
    require'fzf-lua'.live_grep({ prompt = prompt, cmd = rg_cmd, cwd = cwd_dir, winopts = { fullscreen = true } })
end

Komendy = function()
    local lista_komend = {
        "Aktualizacja lini Ostatnia Aktualizacja (OstatniaAktualizacja)",
        "Aktualizacja pluginów (Lazy update)",
        "Alpha Dashboard",
        "Dodaj katalog do ulubionych (AddCDDir)",
        "Dodaj plik do ulubionych (AddBmFile)",
        "Dodaj pliki do repozytorium Git (GA)",
        "Dodaje i wysyła pliki do repozytorium Git (GP)",
        "Dodaje, podpisuje i wysyła pliki do repozytorium Git (GPS)",
        "Edytuj plik konfiguracyjny repozytorium Git .git/config (EditGitConfig)",
        "Edytuj ulubione katalogi ~/.config/bmdirs (EditCDDirs)",
        "Edytuj ulubione pliki ~/.config/bmfiles (EditBmFiles)",
        "Informacje o buforze (BufInfo)",
        "Instalacja nowych pluginów (Lazy install)",
        "Kopiuj bieżącą linię do wybranego pliku Notatek",
        "Kopiuj zaznaczenie do wybranego pliku Notatek",
        "Kopiuje katalog nazwę pliku do rejestru (CopyFileName)",
        "Menadżer plików Neotree",
        "Menadżer plików Oil.nvim",
        "Neorg przejdź do workspace home",
        "Neorg przejdź do workspace work",
        "Nowy plik (NewFileNoSplit)",
        "Nowy plik w podziale pionowym (NewFileVSplit)",
        "Nowy plik w podziale poziomym (NewFileHSplit)",
        "Otwiera plik pod kursorem dodając na początku ścieśki src/ (OpenFile)",
        "Otwórz katalog wybrany z (CDE)",
        "Pobiera zmiany z repozytorium Git (PU)",
        "Pobierz zmiany z repozytorium Git w terminalu (TermGitPull)",
        "Pobierze słownik pisowni języka polskiego (GetSpell)",
        "Pokazuje zmiany w repozytorium Git (FzfLua git_status)",
        "Pokazuje znak · wstawiony w miejsce spacji (ShowMiddleDot)",
        "Pokaż Timer (TimerShow)",
        "Pokaż datę i godzinę (Time)",
        "Pokaż główny katalog repozytorium Git (CDG)",
        "Przejdź do katalogu dla otwartego pliku (CDFD)",
        "Przejdź do katalogu wybranego z ulubionych (CD)",
        "Przeszukiwanie dokumentacji nvim-qfjz (FzfLua live_grep)",
        "Przeszukiwanie historii wyszukiwania (FzfLua search_history)",
        "Przywróc ostatnią sesję (OstatniaSesja)",
        "Skopiuj całą zawartość pliku",
        "Sortuj bufory według numerów (BufferOrderByBufferNumber)",
        "Sprawdza czy w systemie są wymagane programy (CheckExternalReqs)",
        "Ukryj Timer (TimerHide)",
        "Ukrywa znak · wstawiony w miejsce spacji (HideMiddleDot)",
        "Ulubione pliki (BmFiles)",
        "Ustaw Timer na 1 minutę (TimerStart 1m)",
        "Ustaw Timer na 15 minut (TimerStart 15m)",
        "Ustaw Timer na 30 minut (TimerStart 30m)",
        "Ustaw Timer na 5 minut (TimerStart 5m)",
        "Ustaw Timer na 60 minut (TimerStart 60m)",
        "Ustaw jasny schemat kolorystyczny (Light)",
        "Ustaw schemat kolorystyczny na tokyonight-moon (Dark)",
        "Ustawia przezroczystość dla Neovide na 0.2",
        "Ustawia przezroczystość dla Neovide na 1",
        "Usunięcie nieużywanych pluginów (Lazy clean)",
        "Usuwanie zakładek (BookmarksDelete)",
        "Usuń bieżący plik z systemu plików",
        "Usuń całą zawartość pliku",
        "Usuń wszystkie puste linie oraz linie wypełnione znakiem spacji w pliku",
        "Usuń wszystkie puste linie w pliku",
        "Wstaw aktualną datę i godzinę w formacie 2024-07-22 17:28:27",
        "Wstaw znacznik ID",
        "Wstaw znacznik czasu EPOCH",
        "Wstawia znacznik dla przypomnień w programie Obsidian (InsObsdianRemminder)",
        "Wybierz bufor (BufferPick)",
        "Wyczyść wszystkie rejestry (ClearRegs)",
        "Wyjdź bez zapisywania",
        "Wykonaj kopię zapasową plików Neovim (BackupNeovimConfig)",
        "Wyszukaj znacznik ID",
        "Wyszukiwanie dokumentacji nvim-qfjz (Docs)",
        "Wyszukiwanie komend (FzfLua commands)",
        "Wyszukiwanie ostatnio edytowanych plików (FzfLua oldfiles - OldFiles())",
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
        "Wyświetla podręczną pomoc dla skrótów klawiszowych (Skroty)",
        "Wyświetla wersję programu Neovim (CheckVersion)",
        "Włącz / wyłącz numerowanie wierszy (number!)",
        "Włącz / wyłącz relatywne numerowanie wierszy (set relativenumber!)",
        "Włącz / wyłącz tryb ZenMode",
        "Włącz / wyłącz zawijanie linii (Wrap)",
        "Włącz autopairs",
        "Włącz sprawdzanie pisowni",
        "Włącza / wyłącza prowadnice wcięć (IBLToggle)",
        "Włącza prowadnice wcięć (IBLEnable)",
        "Zamiana popularnych słów true / false (BiPolar)",
        "Zamknij aktywny bufor",
        "Zamknij wszystkie bufory poza aktywnym (BufferCloseAllButCurrent)",
        "Zapisz i wyjdź",
        "Zapisz zmiany",
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
    opts.prompt = "Wyszukaj> "
    opts.actions = {
        ['default'] = function(selected)
            local choice = selected[1]
            if choice == "Dodaj plik do ulubionych (AddBmFile)" then
                AddBmFile()
            elseif choice == "Wybierz bufor (BufferPick)" then
                vim.cmd[[BufferPick]]
            elseif choice == "Wyszukiwarka rejestrów" then
                vim.cmd[[FzfLua registers]]
            elseif choice == "Alpha Dashboard" then
                vim.cmd[[Alpha]]
            elseif choice == "Przeszukiwanie dokumentacji nvim-qfjz (FzfLua live_grep)" then
                GrepNvimDocs()
            elseif choice == "Edytuj ulubione pliki ~/.config/bmfiles (EditBmFiles)" then
                EditBmFiles()
            elseif choice == "Dodaj katalog do ulubionych (AddCDDir)" then
                AddCDDir()
            elseif choice == "Wykonaj kopię zapasową plików Neovim (BackupNeovimConfig)" then
                vim.cmd[[BackupNeovimConfig]]
            elseif choice == "Zamiana popularnych słów true / false (BiPolar)" then
                vim.cmd[[BiPolar]]
            elseif choice == "Ulubione pliki (BmFiles)" then
                BmFiles()
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
            elseif choice == "Informacje o buforze (BufInfo)" then
                BufInfo()
            elseif choice == "Wyszukiwanie zakładek (BookmarksAllMarks)" then
                vim.cmd[[BookmarksAllMarks]]
            elseif choice == "Usuwanie zakładek (BookmarksDelete)" then
                vim.cmd[[BookmarksDelete]]
            elseif choice == "Zamknij wszystkie bufory poza aktywnym (BufferCloseAllButCurrent)" then
                vim.cmd[[BufferCloseAllButCurrent]]
            elseif choice == "Sortuj bufory według numerów (BufferOrderByBufferNumber)" then
                vim.cmd[[BufferOrderByBufferNumber]]
            elseif choice == "Przejdź do katalogu wybranego z ulubionych (CD)" then
                CD()
            elseif choice == "Otwórz katalog wybrany z (CDE)" then
                CDE()
            elseif choice == "Przejdź do katalogu dla otwartego pliku (CDFD)" then
                CDFD()
            elseif choice == "Wyczyść wszystkie rejestry (ClearRegs)" then
                ClearRegs()
            elseif choice == "Wyświetla historię komend (CommandLineHistory)" then
                vim.cmd[[CommandLineHistory]]
            elseif choice == "Wyszukiwanie plików konfiguracyjnych Neovim w katalogu $NVIM_APPNAME (Config)" then
                vim.cmd[[Config]]
            elseif choice == "Pokaż główny katalog repozytorium Git (CDG)" then
                CDG()
            elseif choice == "Kopiuje katalog nazwę pliku do rejestru (CopyFileName)" then
                CopyFileName()
            elseif choice == "Ustaw schemat kolorystyczny na tokyonight-moon (Dark)" then
                vim.cmd[[Dark]]
            elseif choice == "Wyłącz wszystkie dekoracje (DesFree)" then
                DesFree()
            elseif choice == "Wyszukiwanie dokumentacji nvim-qfjz (Docs)" then
                Docs()
            elseif choice == "Edytuj ulubione katalogi ~/.config/bmdirs (EditCDDirs)" then
                EditCDDirs()
            elseif choice == "Edytuj plik konfiguracyjny repozytorium Git .git/config (EditGitConfig)" then
                EditGitConfig()
            elseif choice == "Wyświetla informacje o otwartym pliku (FileInfo)" then
                FileInfo()
            elseif choice == "Wyszukiwanie plików w bieżącej lokalizacji (Files)" then
                Files()
            elseif choice == "Wyszukiwanie komend (FzfLua commands)" then
                vim.cmd[[FzfLua commands]]
            elseif choice == "Wyszukiwanie pomocy Neovim (FzfLua helptags)" then
                vim.cmd[[FzfLua helptags]]
            elseif choice == "Wyszukiwanie skrótów klawiszowych (FzfLua keymaps)" then
                vim.cmd[[FzfLua keymaps]]
            elseif choice == "Wyszukiwanie ostatnio edytowanych plików (FzfLua oldfiles)" then
                OldFiles()
            elseif choice == "Przeszukiwanie historii wyszukiwania (FzfLua search_history)" then
                vim.cmd[[FzfLua search_history]]
            elseif choice == "Dodaj pliki do repozytorium Git (GA)" then
                GA()
            elseif choice == "Wyświetla informacje o repozytorium (GI)" then
                GI()
            elseif choice == "Wyszukuje pliki znajdujące się w repozytorium Git (GitFiles)" then
                GitFiles()
            elseif choice == "Pokazuje zmiany w repozytorium Git (FzfLua git_status)" then
                vim.cmd[[FzfLua git_status]]
            elseif choice == "Dodaje i wysyła pliki do repozytorium Git (GP)" then
                GP()
            elseif choice == "Dodaje, podpisuje i wysyła pliki do repozytorium Git (GPS)" then
                GPS()
            elseif choice == "Pobiera zmiany z repozytorium Git (PU)" then
                PU()
            elseif choice == "Ukrywa znak · wstawiony w miejsce spacji (HideMiddleDot)" then
                vim.cmd[[HideMiddleDot]]
            elseif choice == "Pokazuje znak · wstawiony w miejsce spacji (ShowMiddleDot)" then
                vim.cmd[[ShowMiddleDot]]
            elseif choice == "Wyświetla nazwę systemu (Hostname)" then
                vim.cmd[[Hostname]]
            elseif choice == "Wyłącza prowadnice wcięć (IBLDisable)" then
                vim.cmd[[IBLDisable]]
            elseif choice == "Włącza prowadnice wcięć (IBLEnable)" then
                vim.cmd[[IBLEnable]]
            elseif choice == "Włącza / wyłącza prowadnice wcięć (IBLToggle)" then
                vim.cmd[[IBLToggle]]
            elseif choice == "Wstawia znacznik dla przypomnień w programie Obsidian (InsObsdianRemminder)" then
                InsObsdianRemminder()
            elseif choice == "Zmienia schemat kolorystyczny biorąc pod uwagę porę dnia (KolorPora)" then
                KolorPora()
            elseif choice == "Zmiana schematu kolorystycznego (Kolory)" then
                vim.cmd[[Kolory]]
            elseif choice == "Zmiana języka Neovim na język angielski (language en_US)" then
                vim.cmd[[language en_US]]
            elseif choice == "Zmiana języka Neovim na język polski (language pl_PL.UTF-8)" then
                vim.cmd[[language pl_PL.UTF-8]]
            elseif choice == "Wyświetla ostatni komunikat (LastMsg)" then
                vim.cmd[[LastMsg]]
            elseif choice == "Usunięcie nieużywanych pluginów (Lazy clean)" then
                vim.cmd[[Lazy clean]]
            elseif choice == "Instalacja nowych pluginów (Lazy install)" then
                vim.cmd[[Lazy install]]
            elseif choice == "Aktualizacja pluginów (Lazy update)" then
                vim.cmd[[Lazy update]]
            elseif choice == "Ustaw jasny schemat kolorystyczny (Light)" then
                vim.cmd[[Light]]
            elseif choice == "Wyświetla / ukrywa dekoratory list (List)" then
                vim.cmd[[List]]
            elseif choice == "Sprawdza czy w systemie są wymagane programy (CheckExternalReqs)" then
                CheckExternalReqs()
            elseif choice == "Wyświetla wersję programu Neovim (CheckVersion)" then
                CheckVersion()
            elseif choice == "Ustawia przezroczystość dla Neovide na 0.2" then
                vim.cmd[[lua vim.g.neovide_transparency = 0.2]]
            elseif choice == "Ustawia przezroczystość dla Neovide na 1" then
                vim.cmd[[lua vim.g.neovide_transparency = 1]]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 12" then
                vim.cmd[[lua vim.o.guifont = 'Source Code Pro:h12']]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 17" then
                vim.cmd[[lua vim.o.guifont = 'Source Code Pro:h17']]
            elseif choice == "Zmienia rozmiar czcionki dla Neovide na 21" then
                vim.cmd[[lua vim.o.guifont = 'Source Code Pro:h21']]
            elseif choice == "Wyświetla komunikaty (Messages)" then
                vim.cmd[[Messages]]
            elseif choice == "Ukryj Timer (TimerHide)" then
                vim.cmd[[TimerHide]]
            elseif choice == "Pokaż Timer (TimerShow)" then
                vim.cmd[[TimerShow]]
            elseif choice == "Neorg przejdź do workspace home" then
                vim.cmd[[Neorg workspace home]]
            elseif choice == "Neorg przejdź do workspace work" then
                vim.cmd[[Neorg workspace work]]
            elseif choice == "Otwórz nowy plik w podziale poziomym (NewFileHSplit)" then
                vim.cmd[[NewFileHSplit]]
            elseif choice == "Otwórz nowy plik w podziale pionowym (NewFileVSplit)" then
                vim.cmd[[NewFileVSplit]]
            elseif choice == "Otwórz nowy plik (NewFileNoSplit)" then
                vim.cmd[[NewFileNoSplit]]
            elseif choice == "Wyświetla nazwę zmiennej NVIM_APPNAME" then
                print(NvimAppName())
            elseif choice == "Otwiera plik pod kursorem dodając na początku ścieśki src/ (OpenFile)" then
                vim.cmd[[OpenFile]]
            elseif choice == "Aktualizacja lini Ostatnia Aktualizacja (OstatniaAktualizacja)" then
                OstatniaAktualizacja()
            elseif choice == "Przywróc ostatnią sesję (OstatniaSesja)" then
                OstatniaSesja()
            elseif choice == "Włącz / wyłącz numerowanie wierszy (number!)" then
                vim.cmd[[set number!]]
            elseif choice == "Włącz / wyłącz relatywne numerowanie wierszy (set relativenumber!)" then
                vim.cmd[[set relativenumber!]]
            elseif choice == "Włącz sprawdzanie pisowni" then
                vim.cmd[[setlocal spell! spell? spelllang=pl]]
            elseif choice == "Pobierz zmiany z repozytorium Git w terminalu (TermGitPull)" then
                vim.cmd[[TermGitPull]]
            elseif choice == "Wyświetl zmiany w repozytorium Git w terminalu (TermGitStatus)" then
                vim.cmd[[TermGitStatus]]
            elseif choice == "Zmień kolorystyke Jasny / Ciemny (RevBackground)" then
                vim.cmd[[RevBackground]]
            elseif choice == "Wyświetl procesy systemowe (TermPs)" then
                vim.cmd[[TermPs]]
            elseif choice == "Pokaż datę i godzinę (Time)" then
                vim.cmd[[Time]]
            elseif choice == "Włącz / wyłącz zawijanie linii (Wrap)" then
                vim.cmd[[Wrap]]
            elseif choice == "Włącz / wyłącz tryb ZenMode" then
                vim.cmd[[ZenMode]]
            elseif choice == "Zapisz zmiany" then
                Write()
            elseif choice == "Zapisz i wyjdź" then
                Write()
                vim.cmd[[q]]
            elseif choice == "Wyjdź bez zapisywania" then
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
                EPOCH2Date()
            elseif choice == "Wyświetl znacznik czasu EPOCH w czytelnej formie daty" then
                EPOCH2DatePrint()
            elseif choice == "Wstaw znacznik czasu EPOCH" then
                InsertEPOCH()
            elseif choice == "Wstaw aktualną datę i godzinę w formacie 2024-07-22 17:28:27" then
                InsertDate()
            elseif choice == "Wstaw znacznik ID" then
                Insert_ID()
            elseif choice == "Wyszukaj znacznik ID" then
                GrepNvimHash()
            elseif choice == "Skopiuj całą zawartość pliku" then
                vim.cmd[[%yank]]
            elseif choice == "Usuń całą zawartość pliku" then
                vim.cmd[[%delete]]
            elseif choice == "Kopiuj bieżącą linię do wybranego pliku Notatek" then
                CopyLineToSelectedFile()
            elseif choice == "Kopiuj zaznaczenie do wybranego pliku Notatek" then
                CopyVLineToSelectedFile()
            elseif choice == "Wyłącz autopairs" then
                require('nvim-autopairs').disable()
            elseif choice == "Włącz autopairs" then
                require('nvim-autopairs').enable()
            end
        end
    }
    require'fzf-lua'.fzf_exec(lista_komend, opts)
end

EPOCH2Date = function()
    vim.cmd[[norm "tdiwa ]]
    local time = vim.fn.strftime("%F %T", vim.fn.getreg("t"))
    vim.api.nvim_put({time}, "c", false, false)
end

EPOCH2DatePrint = function()
    vim.cmd[[norm "tyiw]]
    local time = vim.fn.strftime("%F %T", vim.fn.getreg("t"))
    vim.notify(time, "info", { timeout = 12000, title = { "EPOCH " .. vim.fn.getreg("t") } })
end

InsertEPOCH = function()
    local time = vim.fn.strftime("%s")
    vim.api.nvim_put({time}, "c", true, true)
end

-- Wstawia aktualną datę i godzinę w formacie 2024-07-22 17:28:27
InsertDate = function()
    local time = vim.fn.strftime("%F %T")
    vim.api.nvim_put({time}, "c", true, true)
end

local function trim(str)
  return str:gsub("^%s+", ""):gsub("%s+$", "")
end

-- DESC: Funkcja wyświetla okno do wprowadzenia nazwy pliku do zapisania, wywoływana przez funcję Write()
InputFilename = function()
    vim.ui.input({ prompt = "Podaj nazwę pliku", default = vim.fn.expand("%:p:h") .. "/", },
    function(input)
        if not input then
            return
        end
        if trim(input) == "" then
            return vim.notify("Podaj nazwę pliku")
        end
        local dir = vim.fs.dirname(input)
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
            vim.notify("Utworzyłem katalog" .. " " .. dir)
        end
        if vim.fn.isdirectory(input) == 1 then
            vim.notify("Podaj nazwę pliku")
            return
        end
        vim.cmd("silent write" .. input)
        vim.notify("Utworzyłem" .. " " .. vim.fn.expand("%:p"))
        CDFD()
    end)
end

-- DESC: Wstawia losowy ciąg znaków w formacie określonym w funkcji Generate_ID
Insert_ID = function()
    local id = Generate_ID()
    vim.cmd[[norm $]]
    vim.api.nvim_put({id}, "c", true, true)
end

-- DESC: Wstawia w bieżącej linii: - [ ] (@2023-09-19 12:07)
InsObsdianRemminder = function()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "- [ ] (@" .. os.date("%F %H:%M") .. ") " .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("A", "n", true)
end

-- DESC: funkcja zmieniająca schemat kolorystyczny w zależności od dygodnia roku i pory dnia
KolorPora = function()
    local tydzien = (vim.fn.strftime("%V"))
    if tonumber(tydzien) > 35 then
        Rano = 6
        Wieczor = 16
    else
        Rano= 5
        Wieczor = 22
    end
    local godzina = (vim.fn.strftime("%H"))
    if (tonumber(godzina) > Rano) and (tonumber(godzina) < Wieczor) then
        vim.cmd([[colorscheme rose-pine-main]])
    else
        vim.cmd([[colorscheme rose-pine-moon]])
    end
end

-- DESC: Skrócony zapis mapowania klawiszy
-- map("n", "<leader>;", ":", { silent = false })
Map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- DESC: Tworzy katalog
MkDir = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

-- DESC: Funkcja zwraca wartość zmiennej systemowej NVIM_APPNAME
NvimAppName = function()
    local app_name = os.getenv("NVIM_APPNAME")
    if app_name == nil then
        app_name = "nvim"
    end
    return app_name
end

-- DESC: Wyszukiwanie plików konfiguracyjnych Neovim w katalogu $HOME/.config/nvim wyklucza katalog plugin
NvimConfig = function()
    local rg_cmd = "rg --files --follow -g '!plugin/' -g '*.lua'"
    local cwd_dir = "$HOME/.config/" .. NvimAppName()
    local prompt = "NvimConfig> "
    require'fzf-lua'.files({
        prompt = prompt,
        cwd = cwd_dir,
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

-- DESC: Wyświetla wszystkie ustawione opcje Neovim, :Messages wyświetla wynik funkcji
Options = function()
    local all_options = vim.api.nvim_get_all_options_info()
    local win_number = vim.api.nvim_get_current_win()
    local v = vim.wo[win_number]
    local all_options = vim.api.nvim_get_all_options_info()
    local result = ""
    for key, val in pairs(all_options) do
        if val.global_local == false and val.scope == "win" then
            result = result .. "\n" .. key .. "=" .. tostring(v[key] or "<not set>")
        end
    end
    print(result)
end

-- DESC: Wyszukuje słowa 'Aktualizacja: ' w górnej częśći pliku i dodaje lub zmienia na bieżącą datę
OstatniaAktualizacja = function()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- local data_aktualizacji = vim.fn.strftime("%Y %b %d")
    local data_aktualizacji = vim.fn.strftime("%F %T, %A %d %B")
    local ln = vim.fn.line("$")
    if ln > 10 then
        ln = 10
    end
    vim.cmd("1," .. ln .. " g/Aktualizacja: /s/Aktualizacja: .*/Aktualizacja: " .. data_aktualizacji)
    vim.api.nvim_win_set_cursor(0, {row, col})
    vim.cmd("norm ")
    vim.cmd[[silent! language en_US]]
end

-- DESC: Przywraca poprzednią sesję
OstatniaSesja = function()
    require('persistence').load({ last = true })
end

-- DESC: Wyświetla zawartość tablicy Lua: ':lua P(vim.api.nvim_get_keymap("n"))'
P = function(v)
    print(vim.inspect(v))
    return v
end

PU = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local PU_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/pu.sh"
    vim.fn.system(PU_SH)
    vim.cmd("e ~/tmp/pu.tmp")
end

PWD = function()
    return(vim.cmd[[pwd]])
end

RevBackground = function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end

SearchDir = function(dir)
    local rg_cmd = "rg --files --follow"
    local prompt = "Search> "
    require'fzf-lua'.files({
        prompt = prompt,
        cmd = rg_cmd,
        cwd = dir,
        winopts = {
            preview = { hidden = "nohidden" },
            fullscreen = true,
        }
    })
end

-- DESC: Przenosi linię do podanego pliku w argumencie
SendLineToFile = function(plik)
    local rejestr
    vim.cmd("d")
    -- vim.cmd("cd $NOTES_DIR")
    rejestr = vim.fn.getreg("@", 1, 1)
    vim.fn.writefile(rejestr, plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Przenosi zaznaczone linie do podanego pliku w argumencie
SendVLineToFile = function(plik)
    local rejestr
    -- vim.cmd[['<,'>d]]
    -- vim.cmd("cd $NOTES_DIR")
    rejestr = vim.fn.getreg("\"", 1, 1)
    vim.fn.writefile(rejestr, plik, "a")
    vim.cmd("cd %:p:h")
end

Skroty = function()
    if Skrot == 1 then
        Skrot = 0
        vim.cmd("pclose")
    else
        Skrot = 1
        vim.cmd("pedit $HOME/.config/" .. NvimAppName() .. "/doc/skroty.md")
    end
end

-- DESC: Sprawdza czy pracuje na zdalnym połączeniu SSH
SSHClient = function()
    local SSH_Connection = os.getenv("SSH_CONNECTION")
    if SSH_Connection ~= nil then
        SSH_Tbl = {}
        for word in SSH_Connection:gmatch("%S+") do
            table.insert (SSH_Tbl, word)
        end
        local Local_IP = SSH_Tbl[3]
        local Remote_IP = SSH_Tbl[1]
        vim.notify(string.format("Z adresu %s, na adres %s", Remote_IP, Local_IP), "info", { timeout = 6000, title = "Połączenie SSH" })
        return
    end
end

SysVersion = function()
    local uv = vim.uv or vim.loop
    vim.notify('System Information: ' .. vim.inspect(uv.os_uname()))
end

-- DESC: Time() wyświetla bieżącą datę i godzinę w formacie 20:53:27 2021-11-23, wtorek 23 październik
Time = function()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local czas = vim.fn.strftime("%T %F, %A %d %B")
    vim.notify(czas, "info", { timeout = 6000 })
    vim.cmd[[silent! language en_US]]
end

TotalLines = function()
    local tl = vim.fn.line("$")
    return tl
end

-- DESC: Wyświetla w dodatkowym oknie VimTips.md
VimTips = function()
    if MyVimTips == 1 then
        MyVimTips = 0
        vim.cmd("pclose")
    else
        MyVimTips = 1
        vim.cmd("pedit $HOME/.config/" .. NvimAppName() .. "/docs/VimTips.md")
    end
end

-- DESC: Zapisuje plik Write()
Write = function()
    for _, v in ipairs(vim.fn.getbufinfo("%")) do
        if v.name == "" then
            vim.notify("Bufor bez nazwy, plik nie zostanie zapisany.")
            InputFilename()
            return
        end
    end
    if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
        vim.cmd("lcd %:p:h")
        for _, v in ipairs(vim.fn.getbufinfo("%")) do
            if v.changed == 1 then
                -- OstatniaAktualizacja()
                vim.cmd("silent update")
                vim.notify("Zapisałem" .. " " .. vim.fn.expand("%:p"))
            else
                vim.notify("Brak zmian w pliku" .. " " .. vim.fn.expand("%:p"))
            end
        end
    else
        MkDir()
        vim.cmd("silent write")
        vim.notify("Utworzyłem" .. " " .. vim.fn.expand("%:p"))
    end
end
