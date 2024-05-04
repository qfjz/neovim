-- hydra
local hydra_status_ok, configs = pcall(require, "hydra")
if not hydra_status_ok then
    return
end

local Hydra = require('hydra')
local cmd = require('hydra.keymap-util').cmd

local hint = [[

 _1_: Timer 1 min     _2_: Timer 5 min 
 _3_: Timer 10 min    _4_: Timer 15 min 
 _5_: Timer 30 min    _6_: Timer 60 min 
 ^
               _<Esc>_
]]

Hydra({
    name = 'TimerMenu',
    hint = hint,
    config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
            position = 'middle',
            border = 'rounded',
        },
    },
    mode = 'n',
    body = '<M-t>',
    heads = {
        { '1', cmd 'TimerStart 1m', { desc = 'Ustawia timer na 1 minutę' } },
        { '2', cmd 'TimerStart 5m', { desc = 'Ustawia timer na 5 minut' } },
        { '3', cmd 'TimerStart 10m', { desc = 'Ustawia timer na 10 minut' } },
        { '4', cmd 'TimerStart 15m', { desc = 'Ustawia timer na 15 minut' } },
        { '5', cmd 'TimerStart 30m', { desc = 'Ustawia timer na 30 minut' } },
        { '6', cmd 'TimerStart 60m', { desc = 'Ustawia timer na 60 minut' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
    }
})

