local M = {}
M.import_styles = {
    --TODO: grow this library
    --TODO: implement alternative styles, such as python: from A import B, C
    --TODO: more certainty about conventions for languages that i don't really use, such as css
    ["lua"] = function (library) return [[local ]]..library..[[ = require("]]..library..[[")]] end,
    ["r"] = function (library) return [[library("]]..library..[[")]] end,
    ["python"] = function (library) return [[import ]]..library end,
    ["tex"] = function (library) return [[\usepackage{]]..library..[[}]] end,
    ["go"] = function (library) return [[import "]]..library..[["]] end,
    ["rust"] = function (library) return [[use ]]..library..[[;]] end,
    ["c"] = function (library) return [[#include "]]..library..[["]] end,
    ["css"] = function (library) return [[@import ]]..library..[[;]]end,
}

return M
