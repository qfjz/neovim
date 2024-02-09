# Funkcje

Aktualizacja: 2024-02-09 10:03:47, piątek 09 lutego

## CD

```lua
CD = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        vim.notify("Brak zmiennej systemowej \"BM_DIRS\"")
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

## CDE

```lua
CDE = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        vim.notify("Brak zmiennej systemowej \"BM_DIRS\"")
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

## CDFD

Funkcja przechodzi do katalogu w którym znajduje się edytorwany plik, potrafi podążać za linkami
symbolicznymi.

```lua
CDFD = function()
    -- Desc: Funkcja przechodzi do katalogu w którym znajduje się edytorwany plik, potrafi podążać za linkami symbolicznymi
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

## CDG

Funkcja wyświetla główny katalog repozytorium Git.

```lua
CDG = function()
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
```

Stara wersja:

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

## GitFiles

Uruchamia FzfLua git_files

W sytuacji kiedy jesteśmy w repozytorium Git wyszukiwane są wyłącznie pliki dodane do repozytorium!!!

```lua
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
```

## Files

Uruchamia FzfLua files

```lua
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
```

## PWD

```lua
PWD = function()
    return(vim.cmd[[pwd]])
end
```

## NvimAppName

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

## NvimConfig

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

## CopyReg

Kopiuje zawartość standardowego rejestru `"` do rejestru `x`.

```lua
CopyReg = function()
    vim.fn.setreg("x", vim.fn.getreg('"'))
end
```

## KolorPora

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

## P

```lua
P = function(v)
    print(vim.inspect(v))
    return v
end
```

## FileInfo

```lua
FileInfo = function()
    -- Desc: Wyświetla informacje o pliku
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    Msg=""
    Msg=Msg .. "Mod: " .. vim.fn.strftime("%F %T",vim.fn.getftime(Filename)) .. " " .. Filename .. ", Size: " ..  FileSize() .. ", TL# " .. TotalLines()
    print(Msg)
end
```

## FileSize

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

## TotalLines

```lua
TotalLines = function()
    local tl = vim.fn.line("$")
    return tl
end
```

## MkDir

```lua
MkDir = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end
```

## Write

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

## Skroty

```lua
Skroty = function()
    if Skrot == 1 then
        Skrot = 0
        vim.cmd("pclose")
    else
        Skrot = 1
        vim.cmd("pedit $HOME/.config/" .. NvimAppName() .. "/doc/skroty.md")
    end
end
```

## GP

```lua
GP = function()
    -- Desc: Uruchamia skrypt `sh/gp.sh`
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GP_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gp.sh"
    vim.fn.system({GP_SH, '-v', '-f %:p'})
    vim.cmd("redraw!")
end
```

## GPS

```lua
GPS = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GPS_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gps.sh"
    vim.fn.system({GPS_SH, '-v', '-f %:p'})
    vim.cmd("redraw!")
end
```

## GI

```lua
GI = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GI_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gi.sh"
    local l = vim.fn.system(GI_SH .. " " .. "vim")
    local l = vim.fn.substitute(l, '\n$', '', '')
    print(l)
end
```

## PU

```lua
PU = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local PU_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/pu.sh"
    vim.fn.system(PU_SH)
    vim.cmd("e ~/tmp/pu.tmp")
end
```
## FindNotesDir

```lua
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
```

## BmFiles

```lua
BmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    if vim.fn.filereadable(BmFiles) == 0 then
        io.open(BmFiles, "a+")
    end
    local files = vim.fn.readfile(vim.fn.expand(BmFiles))
    opts = {}
    opts.prompt = "Files> "
    opts.actions = {
        ['default'] = function(selected)
            vim.cmd("e " .. selected[1])
        end
    }
    require'fzf-lua'.fzf_exec(files, opts)
end
```

## Add_BMFile

```lua
Add_BMFile = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    local BmFilesHandle = io.open(BmFiles, "a+")
    local FileName = vim.fn.resolve(vim.fn.expand("%:p"))
    BmFilesHandle:write(FileName .. "\n")
    BmFilesHandle:close()
end
```

## EditBmFiles

```lua
EditBmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    vim.cmd('e' .. BmFiles)
end
```

## OstatniaAktualizacja

```lua
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
    vim.cmd[[silent! language en_US]]
    vim.cmd("norm ")
end
```
