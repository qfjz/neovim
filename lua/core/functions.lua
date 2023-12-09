-- functions
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
      print("Found git repository at", root_dir)
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
        -- vim.notify("rose-pine-main")
    else
        vim.cmd([[colorscheme rose-pine-moon]])
        -- vim.notify("rose-pine-moon")
    end
end

P = function(v)
    print(vim.inspect(v))
    return v
end
