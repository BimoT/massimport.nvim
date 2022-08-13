local bigtable = require("massimport.bigtable").import_styles
local api = vim.api

local U = {}

function U.detect_filetype()
    --[[ Detects filetype based on plenary, or vim.fn.filetype, or returns an empty string.
         TODO: interaction with LSP or treesitter
    --]]
    local filetype
    local plenaryft_ok, plenaryft = pcall(require, "plenary.filetype")
    if plenaryft_ok then
        local file = vim.fn.expand("%:p")
        filetype = plenaryft.detect(file)
    else
        filetype = vim.bo.filetype
    end
    return filetype or ""
end

function U.get_visual_region()
    --[[ returns: current visual selection, start of selection, end of selection.
         It calculates the first and last position and returns those, not the "actual" start and end of selection.
         This makes setting the selection much easier.
         You CANNOT use nvim_buf_get_mark(0, "<") for this because that does not update
            until AFTER you leave the visual selection.
    --]]
    local _, region_start, _, _ = unpack(vim.fn.getpos("v"))
    local region_end, _ = unpack(api.nvim_win_get_cursor(0))
    
    -- The next 2 lines the minimum and maximum value are calculated so that it is easier to set/get lines.
    local line1 = math.min(region_start, region_end)
    local line2 = math.max(region_start, region_end)

    local lines = api.nvim_buf_get_lines(0, line1 - 1, line2, false)

    return lines, line1, line2
end

function U.parse_input(myinput, manual_filetype)
    --[[ Takes in a table of strings or a single string.
         If the input is a string, then it is split by spaces.
         Optional argument for manual_filetype for easy testing.
         returns: table 
    --]]
    local filetype = manual_filetype or U.detect_filetype()
    if filetype == "" then return {} end

    local imports_table = {}
    local importconverter = bigtable[filetype]
    if not importconverter then return {} end
    if type(myinput) == "table" then
        local counter =1
        for _, item in ipairs(myinput) do
            if item ~= "" then
                imports_table[counter] = importconverter(item)
                counter = counter + 1
            end
        end
    elseif type(myinput) == "string" then
        local counter = 1
        for word in myinput:gmatch("%S+") do --everything but space
            if word ~= "" then
                imports_table[counter] = importconverter(word)
                counter = counter + 1
            end
        end
    end
    return imports_table
end

return U
