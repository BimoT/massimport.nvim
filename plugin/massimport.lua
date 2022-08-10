-- makes sure that massimport will not get loaded multiple times
if vim.g.loaded_massimport == 1 then return end
vim.g.loaded_massimport = 1

--[[ Allows the user to call :Massimport ]]
vim.api.nvim_create_user_command("Massimport",
    function (opts)
        require("massimport.core").massimport_commandmode(opts.fargs)
    end,
    {
        nargs = "*", -- arguments can be supplied
    }
)

--[[ Keybinding in normal mode: ]]
-- vim.api.nvim_set_keymap("n",
--     "<leader>mi",
--     "<cmd>lua require('massimport').massimport_normalmode()<cr>",
--     { nowait = true, silent = true }
-- )
--[[ Keybinding in visual + selection mode: ]]
-- vim.api.nvim_set_keymap("x",
--     "<leader>mi",
--     "<cmd>lua require('massimport').massimport_visualmode()<cr>",
--     { nowait = true, silent = true }
-- )
