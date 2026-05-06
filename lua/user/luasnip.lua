local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

---------------
-- Lua Snippets
---------------
luasnip.add_snippets("lua", {
  s(
    "print_table",
    fmt(
      [[
    for {}, {} in pairs({}) do
        print({}, {})
    end
    ]],
      {
        i(1, "k"),
        i(2, "v"),
        i(3, "table"),
        rep(1),
        rep(2),
      }
    )
  ),
  s(
    "new_object",
    fmt(
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

    ---@return {}
    function {}:create(...)
        return {}(...)
    end
    ]],
      {
        rep(1), -- LDoc Class Name (mirrors i(1))
        rep(2), -- LDoc Parent Name (mirrors i(2))
        i(1, "name"), -- {1} THE CLASS NAME (The primary entry point)
        i(2, "parent"), -- {2} The Parent Class being extended
        rep(1), -- function name:new
        i(3, "params"), -- {3} Constructor parameters
        rep(1), -- self.super access inside :new
        rep(3), -- passing params to super constructor
        rep(1), -- function name:update
        rep(1), -- self.super access inside :update
        rep(1), -- function name:draw
        rep(1), -- function name:destroy
        rep(1), -- self.super access inside :destroy
        rep(1), -- LDoc @return type
        rep(1), -- function name:create
        rep(1), -- the constructor call inside :create
      }
    )
  ),
  s(
    "class",
    fmt(
      [[
    ---@class {}
    ]],
      {
        i(1, "class_name"),
      }
    )
  ),
  s(
    "field",
    fmt(
      [[
    ---@field {} {}
    ]],
      {
        i(1, "name"),
        i(2, "type"),
      }
    )
  ),
})

--------------------
-- GDScript Snippets
--------------------
luasnip.add_snippets("gdscript", {
  s(
    "save_load",
    fmt(
      [[
func on_save_game(saved_data: Array[SavedData]) -> void:
	var data := Saved{}Data.new()
	data.position = global_position
	data.scene_path = scene_file_path
	{}
	saved_data.append(data)


func on_load_game(saved_data: SavedData) -> void:
	global_position = saved_data.position
	if saved_data is Saved{}Data:
		var data := saved_data as Saved{}Data
    ]],
      {
        i(1, "Name"), -- {1} The data type name
        i(0), -- {0} Final cursor position for extra logic
        rep(1), -- Repeat of {1} for the 'if' check
        rep(1), -- Repeat of {1} for the 'as' cast
      }
    )
  ),
  s("onready", {
    t("@onready var "),
    i(1, "name"),
    t(": "),
    i(2, "Type"),
    t(" = $"),
    rep(2),
  }),
  s({ trig = "funcl", dscr = "Empty lambda function." }, {
    t("func"),
    t("("),
    i(1), -- The arguments (empty by default)
    t(") -> void:"),
    t({ "", "\t" }), -- Newline and indentation
    i(0), -- Final cursor position
    t({ "", "" }),
  }),
  s("value", {
    t("value: float, "),
  }),
})
