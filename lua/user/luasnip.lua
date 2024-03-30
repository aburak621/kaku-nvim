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
    )
    -- t("for "), i(1, "k"), t(", "), i(2, "v"), t(" in pairs("), i(3, "table"), t({ ") do", "" }),
    -- t("\tprint("), rep(1), t(", "), rep(2), t({ ")", "" }),
    -- t("end"),
    )
})
