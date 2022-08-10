
describe("massimport", function ()
    it("can be required", function ()
        require("massimport.utils")
    end)

    it("can parse a lua table", function ()
        local expected = {[[local one = require("one")]], [[local two = require("two")]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "lua")
        assert.are.same(trying, expected)
    end)

    it("can parse an R table", function ()
        local expected = {[[library("one")]], [[library("two")]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "r")
        assert.are.same(trying, expected)
    end)

    it("can parse a python table", function ()
        local expected = {[[import one]], [[import two]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "python")
        assert.are.same(trying, expected)
    end)
    
    it("can parse a latex table", function ()
        local expected = {[[\usepackage{one}]], [[\usepackage{two}]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "tex")
        assert.are.same(trying, expected)
    end)
end)
