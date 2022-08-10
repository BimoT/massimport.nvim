-- Neovim plugin for quickly writing import statements
-- Maintainer: bimot

local I = {}

function I.setup(user_opts)
    --[[ Simple setup, currently only two options are allowed:
         normalmode_keys: [string], default "<leader>m". Your custom keybinding for the normal mode.
         visualmode_keys: [string], default "<leader>m". Your custom keybinding for the visual mode.
    --]]
    local user_opts = user_opts or {}
    local defaults = { normalmode_keys = "<leader>m", visualmode_keys = "<leader>m", }
    local opts = vim.tbl_extend("force", defaults, user_opts)
    local normal_cmd = "<cmd>lua require('massimport.core').massimport_normalmode()<cr>"
    local visual_cmd = "<cmd>lua require('massimport.core').massimport_visualmode()<cr>"

    -- for safety, firstly it checks if anything else already maps to the functions
    if vim.fn.hasmapto(normal_cmd, "n") <= 0 and opts.normalmode_keys ~= "" then
        vim.api.nvim_set_keymap("n",
            opts.normalmode_keys,
            normal_cmd,
            { nowait = true, silent = true }
        )
    end

    if vim.fn.hasmapto(visual_cmd, "x") <= 0 and opts.visualmode_keys ~= "" then
        vim.api.nvim_set_keymap("x",
            opts.visualmode_keys,
            visual_cmd,
            { nowait = true, silent = true }
        )
    end
end

return I
