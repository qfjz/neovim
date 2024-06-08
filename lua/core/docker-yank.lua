-- kopiowanie w kontenerze DOCKER
local DockerENV = os.getenv("DOCKER")

if DockerENV ~= nil then
    -- Ustawienie parametru clipboard
    vim.opt.clipboard=""
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = vim.api.nvim_create_augroup('YankPost', { clear = true }),
        pattern = '*',
        callback = function()
            -- 172.17.0.1 adres IP hosta, do którego kontener wysyła skopiowany tekst
            vim.cmd[[call system('nc 172.17.0.1 8066', @0)]]
        end,
    })
end
