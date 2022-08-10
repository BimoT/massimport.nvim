local api = vim.api
local utils = require("massimport.utils")
local C = {}

function C.massimport_visualmode()
    --[[ only run this in visual mode ]]
    local selected_region, region_start, region_end = utils.get_visual_region()
    local importtable = utils.parse_input(selected_region)
    if importtable then
        api.nvim_buf_set_lines(0, region_start - 1, region_end, false, importtable)
    end
end

function C.massimport_commandmode(fargs)
    --[[ Only run this in command mode.
         fargs: table
         If fargs are not provided, then gets run as normal mode.
    --]]
    if fargs and not vim.tbl_isempty(fargs) then
        local cursor = api.nvim_win_get_cursor(0)[1] or 1
        local importtable = utils.parse_input(fargs)
        if importtable then
            api.nvim_buf_set_lines(0, cursor - 1, cursor, false, importtable)
        end
    else
        C.massimport_normalmode()
    end
end

function C.massimport_normalmode()
    --[[ Only run this in normal mode, with no arguments. ]]
    local currentline = api.nvim_get_current_line()
    local tbl_of_strings = vim.split(currentline, "%s+", { trimempty = true })
    local importtable = utils.parse_input(tbl_of_strings)
    if importtable then
        local cursor = api.nvim_win_get_cursor(0)[1] or 1
        api.nvim_buf_set_lines(0, cursor - 1, cursor, false, importtable)
    end
end

return C
