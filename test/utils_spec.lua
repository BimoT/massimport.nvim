
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

    it("can parse a go table", function ()
        local expected = {[[import "one"]], [[import "two"]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "go")
        assert.are.same(trying, expected)
    end)

    it("can parse a rust table", function ()
        local expected = {[[use one;]], [[use two;]]}
        local trying = require("massimport.utils").parse_input({"one", "two"}, "rust")
        assert.are.same(trying, expected)
    end)
    
    it("can parse a c table", function ()
        local expected = {[[#include "one"]], [[#include "two"]]}
        local trying = require("massimport.utils").parse_input({[["one"]], [["two"]]}, "c")
        assert.are.same(trying, expected)
    end)
end)
