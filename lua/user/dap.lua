local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end
local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  return
end

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

  -- On windows you may have to uncomment this:
  detached = vim.fn.has("win32") == 1 and false or nil,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  },
}

vim.keymap.set("n", "<leader>d?", function()
  require("dapui").eval(nil, { context = "repl", width = 100, height = 25, enter = true })
end)

local M = {}

M.dap = {
  plugin = true,
}

return M
