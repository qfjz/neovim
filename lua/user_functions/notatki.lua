local M = {}

-- DESC: Przeszukuje katalog $NOTES_DIR
function M.GrepNotesDir()
    local rg_cmd = "rg --line-number --column -g '*.md' -g '*.norg'"
    local notes_dir = os.getenv("NOTES_DIR")
    require"fzf-lua".live_grep({
        prompt = notes_dir .. " > ",
        cmd = rg_cmd,
        cwd = notes_dir,
        file_icons = false,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Grep Notes ",
            fullscreen = true,
        }
    })
end

function M.FindNotesDir()
    local rg_cmd = "rg --files --follow -g '*.md' -g '*.norg'"
    local cwd_dir = os.getenv("NOTES_DIR")
    if cwd_dir == nil then
        cwd_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local prompt = "Notatki> "
    require"fzf-lua".files({
        prompt = prompt,
        cmd = rg_cmd,
        cwd = cwd_dir,
        winopts = {
            preview = { hidden = "nohidden" },
            title = " Notatki ",
            fullscreen = true,
        }
    })
end

-- DESC: Kopiuje linię do wybranego pliku (*.md) z katalogu $NOTES_DIR
function M.CopyLineToSelectedFile()
    local notes_dir = os.getenv("NOTES_DIR")
    if notes_dir == nil then
        notes_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local pliki_scan = vim.fn.system("rg --files -g '*.md' " .. notes_dir)
    local pliki_notatek = vim.fn.substitute(pliki_scan, "\n$", "", "")  -- usunięcie ostatniej pustej linii w tablicy
    local pliki_notatek_table = vim.split(pliki_notatek, " ")
    local opts = {}
    opts.prompt = " Wybierz plik > "
    opts.winopts = { title = " Copy Line To Selected File " }
    opts.actions = {
        ["default"] = function(selected)
            local plik = selected[1]
            vim.cmd("y")
            vim.fn.writefile(vim.fn.getreg("@", 1, 1), vim.fn.resolve(vim.fn.expand(plik)), "a")
            vim.cmd("cd %:p:h")
        end
    }
    require"fzf-lua".fzf_exec(pliki_notatek_table, opts)
end

-- DESC: Kopiuje zaznaczone linie do wybranego pliku (*.md) z katalogu $NOTES_DIR
function M.CopyVLineToSelectedFile()
    local notes_dir = os.getenv("NOTES_DIR")
    if notes_dir == nil then
        notes_dir = vim.fn.resolve(vim.fn.expand("$HOME/Notes"))
    end
    local pliki_scan = vim.fn.system("rg --files -g '*.md' " .. notes_dir)
    local pliki_notatek = vim.fn.substitute(pliki_scan, "\n$", "", "")  -- usunięcie ostatniej pustej linii w tablicy
    local pliki_notatek_table = vim.split(pliki_notatek, " ")
    local opts = {}
    opts.prompt = " Wybierz plik > "
    opts.winopts = { title = " Copy Line To Selected File " }
    opts.actions = {
        ["default"] = function(selected)
            local plik = selected[1]
            vim.cmd("'<,'>y")
            vim.fn.writefile(vim.fn.getreg("@", 1, 1), vim.fn.resolve(vim.fn.expand(plik)), "a")
            vim.cmd("cd %:p:h")
        end
    }
    require"fzf-lua".fzf_exec(pliki_notatek_table, opts)
end

-- DESC: Wstawia w bieżącej linii: - [ ] (@2023-09-19 12:07)
function M.InsObsdianReminder()
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. "- [ ] (@" .. os.date("%F %H:%M") .. ") " .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_feedkeys("A", "n", true)
end

return M
