local M = {}

BmDirs = os.getenv("BM_DIRS")
BmFiles = os.getenv("BM_FILES")

-- DESC: Dodaje edytowany plik do bmfiles
function M.AddBmFile()
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
function M.AddCDDir()
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

-- DESC: Pokazuje okno wyboru ulubionych plików
function M.BmFiles()
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfiles"))
    end
    if vim.fn.filereadable(BmFiles) == 0 then
        io.open(BmFiles, "a+")
    end
    local files = vim.fn.readfile(vim.fn.expand(BmFiles))
    local opts = {}
    opts.prompt = "Files > "
    opts.winopts = { title = " Ulubione pliki " }
    opts.actions = {
        ["default"] = function(selected)
            vim.cmd("e " .. selected[1])
        end
    }
    require"fzf-lua".fzf_exec(files, opts)
end

-- DESC: Standardowo zmienna $BM_DIRS zaweira nazwę pliku w której znajdują się często odwiedzane katalogi
--Zazwyaczaj jest to plik `$HOME/.config/bmdirs`.
function M.CD()
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    if vim.fn.filereadable(BmDirs) == 0 then
        io.open(BmDirs, "a+")
    end
    local command = "cd"
    local opts = {}
    opts.prompt = "CD > "
    opts.winopts = { title = " Katalogi " }
    opts.actions = {
        ["default"] = function(selected)
            -- wywołanie komendy na wybranym katalogu
            vim.cmd(command .. " " .. selected[1])
        end
    }
    local files = vim.fn.readfile(vim.fn.expand(BmDirs))
    require"fzf-lua".fzf_exec(files, opts)
end

-- DESC: Otwiera menadżer plików w wybranej lokalizacji
function M.CDE()
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    if vim.fn.filereadable(BmDirs) == 0 then
        io.open(BmDirs, "a+")
    end
    local command = "e"
    local opts = {}
    opts.prompt = "CDE > "
    opts.winopts = { title = " Katalogi " }
    opts.actions = {
        ["default"] = function(selected)
            -- wywołanie komendy na wybranym katalogu
            vim.cmd(command .. " " .. selected[1])
        end
    }
    local files = vim.fn.readfile(vim.fn.expand(BmDirs))
    require"fzf-lua".fzf_exec(files, opts)
end

-- DESC: Edycja pliku bmfiles
function M.EditBmFiles()
    if BmFiles == nil then
        BmFiles = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmfiles"))
    end
    vim.cmd("e" .. BmFiles)
end

-- DESC: Edycja pliku bmdirs
function M.EditCDDirs()
    if BmDirs == nil then
        BmDirs = vim.fn.resolve(vim.fn.expand("$HOME/.config/bmdirs"))
    end
    vim.cmd("e" .. BmDirs)
end

return M
