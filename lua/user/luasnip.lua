local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("lua", {
    s("print_table", fmt(
        [[
        for {}, {} in pairs({}) do
            print({}, {})
        end
        ]], {
            i(1, "k"), i(2, "v"), i(3, "table"), rep(1), rep(2)
        }
    )),
    s("new_object", fmt(
        [[
        ---@class {}: {}
        {} = {}:extend()

        function {}:new({})
            {}.super.new(self, {})
        end

        function {}:update(dt)
            {}.super.update(self, dt)
        end

        function {}:draw()
        end

        function {}:destroy()
            {}.super.destroy(self)
        end
        ]], {
            rep(1), rep(2), i(1, "name"), i(2, "parent"), rep(1), i(3, "params"), rep(1), rep(3), rep(1), rep(1), rep(1), rep(1), rep(1)
        }
    )),
    s("class", fmt([[
        ---@class {}
        ]], {
        i(1, "class_name")
    }
    )),
    s("field", fmt([[
        ---@field {} {}
        ]], {
        i(1, "name"), i(2, "type")
    }
    )),
})
