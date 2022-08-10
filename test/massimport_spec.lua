local mock = require("luassert.mock")
local stub = require("luassert.stub")

describe("massimport", function ()
    it("can be required", function ()
        require("massimport")
    end)

    it("can parse a table", function ()
        local expected = {[[local one = require("one")]], [[local two = require("two")]]}
        local trying = require("massimport.utils").parse_input({"one", "two"})
        assert.are.same(trying, expected)
    end)

    it("can parse a string", function ()
        local expected = {[[local one = require("one")]], [[local two = require("two")]]}
        local trying = require("massimport.utils").parse_input("one two")
        assert.are.same(trying, expected)
    end)
    
end)
