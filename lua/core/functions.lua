-- functions.lua
AddBmFile = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    local BmFilesHandle = io.open(BmFiles, "a+")
    local FileName = vim.fn.resolve(vim.fn.expand("%:p"))
    BmFilesHandle:write(FileName .. "\n")
    BmFilesHandle:close()
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
end

-- DESC: kopiuje zawartość standardowego rejestru " do rejestru x
CopyReg = function()
    vim.fn.setreg("x", vim.fn.getreg('"'))
    vim.notify("Skopiowałem standardowy rejestr do rejestru 'x'")
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

EditBmDirs = function()
    local BmDirs = os.getenv("BM_DIRS")
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    vim.cmd('e' .. BmDirs)
end

EditBmFiles = function()
    local BmFiles = os.getenv("BM_FILES")
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfilles"))
    end
    vim.cmd('e' .. BmFiles)
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

-- DESC: edycja plików konfiguracyjnych
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
    vim.cmd("norm ")
end

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

Skroty = function()
    if Skrot == 1 then
        Skrot = 0
        vim.cmd("pclose")
    else
        Skrot = 1
        vim.cmd("pedit $HOME/.config/" .. NvimAppName() .. "/doc/skroty.md")
    end
end

-- DESC: Sprawdza czy pracuje na zdalnym połączeniu SSh
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
    local czas = vim.fn.strftime("%T %F, %A %d %B")
    vim.notify(czas, "info", { timeout = 6000 })
end

TotalLines = function()
    local tl = vim.fn.line("$")
    return tl
end

-- DESC: Zapisuje plik Write()
Write = function()
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
