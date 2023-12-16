# Neovim + Lua

![screenshot](screenshot.png)

## Przypisane skróty klawiszowe

| Skrót         | Opis                                                                                      |
|---------------|-------------------------------------------------------------------------------------------|
| `Shift+Enter` | Dodaje pustą linię powyżej bieżącej                                                       |
| `Enter`       | Dodaje pustą linię poniżej bieżącej                                                       |
| `<leader>n`   | Uruchamia menadżer plików NeoTree                                                         |
| `\`           | Uruchamia menadżer plików NeoTree                                                         |
| `gh`          | Początek linii                                                                            |
| `gl`          | Koniec linii                                                                              |
| `<leader>,`   | Poprzeni bufor                                                                            |
| `<leader>.`   | Następny bufor                                                                            |
| `<leader>w`   | Zapisanie zmian                                                                           |
| `qq`          | Wyjśćie                                                                                   |
| `<leader>;`   | Wejście do trybu COMMAND                                                                  |
| `<c-h>`       | Przechodzi do okna po lewej                                                               |
| `<c-l>`       | Przechodzi do okna po prawej                                                              |
| `<c-j>`       | Przechodzi do okna niżej                                                                  |
| `<c-k>`       | Przechodzi do okna wyżej                                                                  |
| `<leader>so`  | Wczytuje bieżący plik Lua                                                                 |
| `<leader>d`   | Usuwa bufor                                                                               |
| `gf`          | Otwiera plik pod kursorem                                                                 |
| `dh`          | Usuwa od kursora do początku linii                                                        |
| `dl`          | Usuwa od kursora do końca linii                                                           |
| `<leader>sv`  | Dzieli okno w pionie                                                                      |
| `<leader>sp`  | Dzieli okno w poziomie                                                                    |
| `<leader>v`   | Wyszukiwarka plików konfiguracyjnych                                                      |
| `yA`          | Kopiuje całą zawartość pliku do rejestru                                                  |
| `<space>m`    | Kopiuje zawartość głównego rejestru do rejestru `x`                                       |
| `M`           | Wkleja zawartość rejestru `x`, standardowo klawisz `M` przenosi kursor na środek ekranu   |
| `<leader>C`   | Tworzy nowy plik                                                                          |
| `<F9>`        | Zmiana tematu kolorystycznego w zależności od pory dnia                                   |
| `Ctrl+/`      | Tworzy komentarz                                                                          |
| `+`           | Zwiększa wartość liczby                                                                   |
| `-`           | Zmniejsza wartość liczby                                                                  |
| `<leader>b`   | Przełączanie pomiędzy buforami                                                            |
| `<tab>`       | Przełączanie pomiędzy dwoma ostatnimi buforami                                            |
| `<leader>o`   | Pozostawia otwarte tylko aktywne okno                                                     |
| `<leader>c`   | Zamyka aktywne okno                                                                       |
| `<esc>`       | Wyłącza wyróżnianie szukanego tekstu                                                      |
| `<leader>g`   | FzfLua live grep                                                                          |
| `<leader>f`   | FzfLua files                                                                              |
| `<leader>l`   | Uruchamia menadżer plików LF                                                              |
| `U`           | Przywraca zmiany                                                                          |
| `gj`          | Następna zmiana w pliku - Git                                                             |
| `gk`          | Poprzednia zmiana w pliku - Git                                                           |
| `Alt+o`       | Hydra menu                                                                                |
| `s + 2 znaki` | Rozpoczyna wyszukiwanie za pomocą pluginu `flash.nvim`                                    |
| `<leader>z`   | Uruchamia tryb Zen                                                                        |

## Komendy

| Komenda       | Opis                                                                                  |
|---------------|---------------------------------------------------------------------------------------|
| `Kolory`      | Komenda uruchamia menu wyboru schematu kolorystycznego z podglądem na żywo            |
| `CDFD`        | Zmienia katalog na katalog edytowanego pliku                                          |
| `CD`          | Uruchamia menu z wyborem katalogu                                                     |
| `CDE`         | Uruchamia menu z wyborem katalogu a następnie uruchamia w nim menadżer plików         |
| `CDG`         | Sprawdza czy plik znajduje się w repozytoriujm Git i wyświetla jego główny katalog    |
| `NvimAppName` | Wyświetla nazwę konfiguracji Neovim                                                   |
| `Config`      | Edycja plików konfiguracyjnych                                                        |

## Funkcje

### CD

```lua
CD = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        print("Brak zmiennej systemowej BM_DIRS")
        return
    end
    command = 'cd'
    opts = {}
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
```

### CDE

```lua
CDE = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        print("Brak zmiennej systemowej BM_DIRS")
        return
    end
    command = 'e'
    opts = {}
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
```

### CDFD

Funkcja przechodzi do katalogu w którym znajduje się edytorwany plik, potrafi podążać za linkami
symbolicznymi.

```lua
CDFD = function()
    local filename = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
    local directory = vim.fs.dirname(filename)
    if directory == nil then
        print("Plik nie ma swojego miejsca na dysku")
        return
    end
    local pwd_dir = vim.fn.system[[pwd]]
    local pwd_dir = vim.trim(pwd_dir)
    if pwd_dir == directory then
        return
    else
        vim.cmd("cd " .. directory)
    end
end
```

### CDG

Funkcja wyświetla główny katalog repozytorium Git.

```lua
CDG = function()
    local root_dir
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
      if vim.fn.isdirectory(dir .. "/.git") == 1 then
        root_dir = dir
        break
      end
    end
    if root_dir then
      print("Found git repository at", root_dir)
    end
end
```

### PWD

```lua
PWD = function()
    return(vim.cmd[[pwd]])
end
```

### NvimAppName

Funkcja zwraca wartość zmiennej systemowej `NVIM_APPNAME`

```lua
NvimAppName = function()
    local app_name = os.getenv("NVIM_APPNAME")
    if app_name == nil then
        app_name = "nvim"
    end
    return app_name
end
```

### NvimConfig

Edycja plików konfiguracyjnych

```lua
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
```

### CopyReg

Kopiuje zawartość standardowego rejestru `"` do rejestru `x`.

```lua
CopyReg = function()
    vim.fn.setreg("x", vim.fn.getreg('"'))
end
```

### KolorPora

Funkcja zmieniająca schemat kolorystyczny w zależności od dygodnia roku i pory dnia.

```lua
KolorPora = function()
    local tydzien = (vim.fn.strftime("%V"))
    if tonumber(tydzien) > 35 then
        rano = 6
        wieczor = 16
    else
        rano= 5
        wieczor = 22
    end
    local godzina = (vim.fn.strftime("%H"))
    if (tonumber(godzina) > rano) and (tonumber(godzina) < wieczor) then
        vim.cmd([[colorscheme rose-pine-main]])
    else
        vim.cmd([[colorscheme rose-pine-moon]])
    end
end
```

### P

```lua
P = function(v)
    print(vim.inspect(v))
    return v
end
```

### FileInfo

```lua
FileInfo = function()
    -- Desc: Wyświetla informacje o pliku
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    Msg=""
    Msg=Msg .. "Mod: " .. vim.fn.strftime("%F %T",vim.fn.getftime(Filename)) .. " " .. Filename .. ", Size: " ..  FileSize() .. ", TL# " .. TotalLines()
    print(Msg)
end
```

### FileSize

```lua
FileSize = function()
    file = vim.fn.resolve(vim.fn.expand("%:p"))
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
```

### TotalLines

```lua
TotalLines = function()
    local tl = vim.fn.line("$")
    return tl
end
```

### MkDir

```lua
MkDir = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end
```

### Write

Zapisuje zmiany

```lua
Write = function()
    -- Desc: Zapisuje plik Write()
    for _, v in ipairs(vim.fn.getbufinfo("%")) do
        if v.name == "" then
            vim.notify("Bufor bez nazwy, plik nie zostanie zapisany.")
            return
        end
    end
    if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
        vim.cmd("lcd %:p:h")
        for _, v in ipairs(vim.fn.getbufinfo("%")) do
            if v.changed == 1 then
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
```
