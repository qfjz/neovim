local M = {}

function M.GA()
    require("user_functions.misc").CDFD()
    local DateTime = vim.fn.strftime("%F %T")
    vim.cmd("Git add -A")
    vim.cmd("silent! Git commit -m '" .. DateTime .. "'")
end

function M.GI()
    require("user_functions.misc").CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GI_SH = HOME_DIR .. "/.config/" .. require("user_functions.misc").NvimAppName() .. "/sh/gi.sh"
    local l = vim.fn.system(GI_SH .. " " .. "vim")
    local l_subs = vim.fn.substitute(l, "\n$", "", "")
    vim.notify(l_subs, "info", {
        timeout = 6000,
        title = "Informacje o repozytorium",
    })
end

-- DESC: Uruchamia skrypt `sh/gp.sh`
function M.GP()
    require("user_functions.misc").CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GP_SH = HOME_DIR .. "/.config/" .. require("user_functions.misc").NvimAppName() .. "/sh/gp.sh"
    vim.fn.system({GP_SH, "-v", "-f %:p"})
    vim.cmd("redraw!")
end

function M.GPS()
    require("user_functions.misc").CDFD()
    local HOME_DIR = os.getenv("HOME")
    local GPS_SH = HOME_DIR .. "/.config/" .. require("user_functions.misc").NvimAppName() .. "/sh/gps.sh"
    vim.fn.system({GPS_SH, "-v", "-f %:p"})
    vim.cmd("redraw!")
end

-- DESC: Funkcja wyświetla główny katalog repozytorium Git
function M.CDG()
    if package.loaded["gitsigns"] then
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

function M.EditGitConfig()
    local git_config_dir = vim.fn.getbufinfo("%")[1].variables.gitsigns_status_dict.gitdir
    vim.cmd("e" .. git_config_dir .. "/config")
end

function M.PU()
    require("user_functions.misc").CDFD()
    local HOME_DIR = os.getenv("HOME")
    local PU_SH = HOME_DIR .. "/.config/" .. require("user_functions.misc").NvimAppName() .. "/sh/pu.sh"
    print(PU_SH)
    vim.fn.system(PU_SH)
    vim.cmd("e ~/tmp/pu.tmp")
end

return M
