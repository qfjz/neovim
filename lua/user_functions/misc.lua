local M = {}

function M.trim(str)
  return str:gsub("^%s+", ""):gsub("%s+$", "")
end

function M.reload_user_module(module)
    vim.notify("Przeładowałem moduł " .. module)
    if package.loaded[module] then
        local filename = vim.fn.resolve(vim.fn.expand("%:p"))
        vim.cmd("luafile " .. filename)
        return require("plenary.reload").reload_module(module)
    else
        return require(module)
    end
end

-- DESC: Funkcja zwraca wartość zmiennej systemowej NVIM_APPNAME
function M.NvimAppName()
    local app_name = os.getenv("NVIM_APPNAME")
    if app_name == nil then
        app_name = "nvim"
    end
    return app_name
end

-- DESC: Funkcja przechodzi do katalogu w którym znajduje się edytowany plik, potrafi podążać za linkami symbolicznymi
function M.CDFD()
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

-- DESC: Przechodzi do głównego katalogu repozytorium Git
function M.CDGitRoot()
    -- require("user_functions.misc").CDFD()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 and result:find("true") then
        local root_dir = vim.fn.system("git rev-parse --show-toplevel")
        vim.cmd("cd " .. root_dir)
    end
end

-- DESC: Wyszukuje pliki w głównym katalogu repozytorium Git
function M.FindGitRoot()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 and result:find("true") then
        ROOT_Dir = vim.fn.system("git rev-parse --show-toplevel")
        vim.cmd("cd " .. ROOT_Dir)
    end
    require("user_functions.misc").FindFilesDir(ROOT_Dir)
end

function M.BiPolar()
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
end

-- DESC: Wyszukuje pliki w głównym katalogu repozytorium Git
function M.GrepGitRoot()
    local GitRoot = require("user_functions.misc").CDGitRoot()
    require("user_functions.misc").GrepDirectory(GitRoot)
end

-- DESC: Przeszukuje katalog podany w parametrze
function M.GrepDirectory(dir)
    local cwd_dir = dir
    local prompt = " Grep > "
    local rg_cmd = "rg --line-number --column"
    require"fzf-lua".live_grep({
        prompt = prompt,
        cmd = rg_cmd,
        cwd = cwd_dir,
        winopts = {
            fullscreen = true,
            title = " Grep Root Git "
        }
    })
end

-- DESC: Wyszukuje plików w przekazanym jako parametr katalogu
function M.FindFilesDir(dir)
    if dir == nil then
        require("user_functions.misc").CDFD()
    else
        CWD = dir
    end
    local rg_cmd = "rg --files --follow -g !.git"
    local prompt = " Files > "
    require"fzf-lua".files({
        prompt = prompt,
        cwd = CWD,
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Wyszukiwarka plików ",
            fullscreen = true,
        }
    })
end

-- DESC: Uruchamia FzfLua files
function M.Files()
    require("user_functions.misc").CDFD()
    local rg_cmd = "rg --files --hidden --follow"
    require"fzf-lua".files({
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Wyszukiwarka plików ",
            fullscreen = true,
        }
    })
end

-- DESC: Uruchamia FzfLua git_files
-- W sytuacji kiedy jesteśmy w repozytorium Git wyszukiwane są wyłącznie pliki dodane do repozytorium!!!
function M.GitFiles()
    require("user_functions.misc").CDFD()
    local result = vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 and result:find("true") then
        local prompt = " GitFiles > "
        require"fzf-lua".git_files({
            prompt = prompt,
            file_icons = false,
            winopts = {
                preview = { hidden = "nohidden" },
                title = " Git Files ",
                fullscreen = true,
            }
        })
    else
        local rg_cmd = "rg --files --hidden --follow"
        local prompt = " Files > "
        require"fzf-lua".files({
            prompt = prompt,
            cmd = rg_cmd,
            file_icons = false,
            winopts = {
                preview = { hidden = "nohidden" },
                title = " Files ",
                fullscreen = true,
            }
        })
    end
end

-- DESC: Wyświetla informacje o bieżącym buforze, informacje można przeglądać za pomocą polecenia Messages
function M.BufInfo()
    for _, v in ipairs(vim.fn.getbufinfo("%")) do
        require("user_functions.misc").P(v)
    end
    vim.cmd[[Messages]]
end

function M.TotalLines()
    local tl = vim.fn.line("$")
    return tl
end

-- DESC: Wyświetla informacje o pliku
function M.FileInfo()
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    Msg=""
    Msg=Msg .. "Mod: " .. vim.fn.strftime("%F %T",vim.fn.getftime(Filename)) .. " " .. Filename .. ", Size: " ..  require("user_functions.misc").FileSize() .. ", TL# " .. require("user_functions.misc").TotalLines()
    vim.notify(Msg, "info", {
        timeout = 6000,
        title = "Informacje o pliku",
    })
end

-- DESC: Przeszukiwanie ostation edytowanych plików
function M.OldFiles()
    require"fzf-lua".oldfiles({
        prompt = " History > ",
        file_icons = false,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Wyszukiwarka plików ",
            fullscreen = true,
        }
    })
end

function M.FileSize()
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

-- DESC: Sprawdza czy w systemie są zainstalowane wymagane programy
function M.CheckExternalReqs()
    for _, exe in ipairs { "git", "make", "unzip", "rg", "fzf" } do
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

-- DESC: Wyświetla wersję Neovim
function M.CheckVersion()
    local verstr = string.format("%s.%s.%s", vim.version().major, vim.version().minor, vim.version().patch)
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

-- DESC: Czyści rejestry
function M.ClearRegs()
    local str = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
    local regs = {}
    for i = 1, #str do
        regs[i] = str:sub(i, i)
    end
    for _, v in ipairs(regs) do
        vim.fn.setreg(v, "")
    end
end

-- DESC: Kopiuje nazwę pliku do schowka systemowego
function M.CopyFileName()
    Filename=vim.fn.resolve(vim.fn.expand("%:p"))
    vim.fn.setreg([[*]], Filename, 1)
    -- vim.fn.setreg([[+]], Filename, 1)
end

-- DESC: kopiuje zawartość standardowego rejestru " do rejestru x
function M.CopyReg()
    vim.fn.setreg("x", vim.fn.getreg('"'))
    vim.notify("Skopiowałem standardowy rejestr do rejestru 'x'")
end

-- DESC: Wstawia w miejscu kursora datę w formacie '# 26.07.23'
function M.DateHeader()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("o", "n", true)
end

-- DESC: Wstawia: "# 2023-07-23 10:15:13, #29, niedziela 23" lipca w miejscu kursora
function M.DateHeaderLong()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "# " .. os.date("%F %T, #%W, %A %d %B") .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("o", "n", true)
    vim.cmd[[silent! language en_US]]
end

-- DESC: Generuje losowy ciąg znaków w formacie "-- #xxxx-xxxx"
-- https://vi.stackexchange.com/questions/39681/how-to-insert-text-from-lua-function-at-cursor-position-insert-mode
function M.Generate_ID()
    math.randomseed(os.time())
    local random = math.random
    local template = "-- #xxxx-xxxx"
    return string.gsub(template, "x", function()
      local v = random(0, 0xf)  -- v is a decimal number 0 to 15
      return string.format("%x", v) --formatted as a hex number
    end)
end

function M.GetSpell()
    vim.cmd("!$HOME/bin/get-spell-pl.sh")
end

-- DESC: Przeszukuje katalog $HOME/.config/NVIM_APPNAME z plikami *.lua dla funkcji GrepNvimHash
function M.GrepNvimConfigDir()
    local cwd_dir = "$HOME/.config/" .. require("user_functions.misc").NvimAppName()
    local prompt = " Config > "
    local rg_cmd = "rg --line-number --column -g '*.lua'"
    require"fzf-lua".grep_cWORD({
        prompt = prompt,
        file_icons = false,
        cmd = rg_cmd,
        cwd = cwd_dir,
        winopts = {
            title = " Grep Config Dir ",
        }
    })
end

function M.EPOCH2Date()
    vim.cmd[[norm "tdiwa ]]
    local time = vim.fn.strftime("%F %T", vim.fn.getreg("t"))
    vim.api.nvim_put({time}, "c", false, false)
end

function M.EPOCH2DatePrint()
    vim.cmd[[norm "tyiw]]
    local time = vim.fn.strftime("%F %T", vim.fn.getreg("t"))
    vim.notify(time, "info", { timeout = 12000, title = { "EPOCH " .. vim.fn.getreg("t") } })
end

function M.InsertEPOCH()
    local time = vim.fn.strftime("%s")
    vim.api.nvim_put({time}, "c", true, true)
end

-- Wstawia aktualną datę i godzinę w formacie 2024-07-22 17:28:27
function M.InsertDate()
    local time = vim.fn.strftime("%F %T")
    vim.api.nvim_put({time}, "c", true, true)
end

-- DESC: Wstawia losowy ciąg znaków w formacie określonym w funkcji Generate_ID
function M.Insert_ID()
    local id = require("user_functions.misc").Generate_ID()
    vim.cmd[[norm $]]
    vim.api.nvim_put({id}, "c", true, true)
end

-- DESC: funkcja zmieniająca schemat kolorystyczny w zależności od dygodnia roku i pory dnia
function M.KolorPora()
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

-- DESC: Tworzy katalog
function M.MkDir()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

-- DESC: Dodaje na końcu pliku ustawienia
function M.Modeline()
    local expandtab = vim.api.nvim_get_option("expandtab")
    local tabstop = vim.api.nvim_get_option("tabstop")
    local shiftwidth = vim.api.nvim_get_option("shiftwidth")
    local textwidth = vim.api.nvim_get_option("textwidth")
    local filetype = vim.opt.filetype:get()
    local commentstring = vim.opt.commentstring:get()
    if expandtab == true then
        expandtab = "expandtab"
    end
    if expandtab == false then
        expandtab = "noexpandtab"
    end
    local ml = string.format("vim: set ft=%s ts=%d sw=%d tw=%d %s :", filetype, tabstop, shiftwidth, textwidth, expandtab)
    local modeline = vim.fn.substitute(commentstring, "%s", ml, "")
    vim.fn.append(("$"), modeline)
end

-- DESC: Wyszukiwanie plików konfiguracyjnych Neovim w katalogu $HOME/.config/nvim wyklucza katalog plugin
function M.NvimConfig()
    local rg_cmd = "rg --files --follow -g '!plugin/' -g '*.lua'"
    local cwd_dir = "$HOME/.config/" .. require("user_functions.misc").NvimAppName()
    local prompt = " NvimConfig > "
    require"fzf-lua".files({
        prompt = prompt,
        cwd = cwd_dir,
        cmd = rg_cmd,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Neovim Config ",
            fullscreen = true,
        }
    })
end

-- DESC: Wyświetla wszystkie ustawione opcje Neovim, :Messages wyświetla wynik funkcji
function M.Options()
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
function M.OstatniaAktualizacja()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
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
function M.OstatniaSesja()
    require("persistence").load({ last = true })
end

-- DESC: Wyświetla zawartość tablicy Lua: ':lua P(vim.api.nvim_get_keymap("n"))'
function M.P(v)
    print(vim.inspect(v))
    return v
end

function M.PWD()
    return(vim.cmd[[pwd]])
end

function M.RevBackground()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end

-- DESC: Kopiuje linię do podanego pliku w argumencie
function M.CopyLineToFile(plik)
    vim.cmd("y")
    -- vim.cmd("cd $NOTES_DIR")
    vim.fn.writefile(vim.fn.getreg("@", 1, 1), plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Kopiuje linię do podanego pliku w argumencie
function M.CopyVLineToFile(plik)
    -- vim.cmd("'<,'>y")
    vim.cmd("y")
    -- vim.cmd("cd $NOTES_DIR")
    vim.fn.writefile(vim.fn.getreg("@", 1, 1), plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Przenosi linię do podanego pliku w argumencie
function M.SendLineToFile(plik)
    local rejestr
    vim.cmd("d")
    -- vim.cmd("cd $NOTES_DIR")
    rejestr = vim.fn.getreg("@", 1, 1)
    vim.fn.writefile(rejestr, plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Przenosi zaznaczone linie do podanego pliku w argumencie
function M.SendVLineToFile(plik)
    local rejestr
    -- vim.cmd[['<,'>d]]
    -- vim.cmd("cd $NOTES_DIR")
    rejestr = vim.fn.getreg("\"", 1, 1)
    vim.fn.writefile(rejestr, plik, "a")
    vim.cmd("cd %:p:h")
end

-- DESC: Sprawdza czy pracuje na zdalnym połączeniu SSH
function M.SSHClient()
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

function M.SysVersion()
    local uv = vim.uv or vim.loop
    vim.notify("System Information: " .. vim.inspect(uv.os_uname()))
end

-- DESC: Time() wyświetla bieżącą datę i godzinę w formacie 20:53:27 2021-11-23, wtorek 23 październik
function M.Time()
    vim.cmd[[silent! language pl_PL.UTF-8]]
    local czas = vim.fn.strftime("%T %F, %A %d %B")
    vim.notify(czas, "info", { timeout = 6000 })
    vim.cmd[[silent! language en_US]]
end

return M
