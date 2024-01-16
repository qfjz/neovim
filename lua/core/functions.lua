-- functions
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

CDG = function()
    -- Desc: Funkcja wyświetla główny katalog repozytorium Git
    local root_dir
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
        if vim.fn.isdirectory(dir .. "/.git") == 1 then
            root_dir = dir
            break
        end
    end
    if root_dir then
        local MSG = ("Found git repository at" .. root_dir)
        vim.notify(MSG, "info", {
            timeout = 6000,
            title = "Informacje o repozytorium",
        })
    end
end

PWD = function()
    return(vim.cmd[[pwd]])
end

NvimAppName = function()
    -- Desc: Funkcja zwraca wartość zmiennej systemowej NVIM_APPNAME
    local app_name = os.getenv("NVIM_APPNAME")
    if app_name == nil then
        app_name = "nvim"
    end
    return app_name
end

NvimConfig = function()
    -- Desc: edycja plików konfiguracyjnych
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

CopyReg = function()
    -- Desc: kopiuje zawartość standardowego rejestru " do rejestru x
    vim.fn.setreg("x", vim.fn.getreg('"'))
    vim.notify("Skopiowałem standardowy rejestr do rejestru 'x'")
end

KolorPora = function()
    -- Desc: funkcja zmieniająca schemat kolorystyczny w zależności od dygodnia roku i pory dnia
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

P = function(v)
    print(vim.inspect(v))
    return v
end

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

FileInfo = function()
    -- Desc: Wyświetla informacje o pliku
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    Msg=""
    Msg=Msg .. "Mod: " .. vim.fn.strftime("%F %T",vim.fn.getftime(Filename)) .. " " .. Filename .. ", Size: " ..  FileSize() .. ", TL# " .. TotalLines()
    print(Msg)
    vim.notify(Msg, "info", {
        timeout = 6000,
        title = "Informacje o pliku",
    })
end

TotalLines = function()
    local tl = vim.fn.line("$")
    return tl
end

MkDir = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

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

Skroty = function()
    if Skrot == 1 then
        Skrot = 0
        vim.cmd("pclose")
    else
        Skrot = 1
        vim.cmd("pedit $HOME/.config/" .. NvimAppName() .. "/doc/skroty.md")
    end
end

GP = function()
    -- Desc: Uruchamia skrypt `sh/gp.sh`
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

GI = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GI_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/gi.sh"
    local l = vim.fn.system(GI_SH .. " " .. "vim")
    local l = vim.fn.substitute(l, '\n$', '', '')
    vim.notify(l, "info", {
        timeout = 6000,
        title = "Informacje o repozytorium",
    })
end

PU = function()
    CDFD()
    local HOME_DIR = os.getenv("HOME")
    local PU_SH = HOME_DIR .. "/.config/" .. NvimAppName() .. "/sh/pu.sh"
    vim.fn.system(PU_SH)
    vim.cmd("e ~/tmp/pu.tmp")
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

EditBmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    vim.cmd('e' .. BmFiles)
end
