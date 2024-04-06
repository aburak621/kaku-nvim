local status_ok, dap = pcall(require, "dap")
local dapui = require("dapui")
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

dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
    },
}

local M = {}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = {
            "<cmd>DapToggleBreakpoint<CR>",
            "Add breakpoint at line",
        },
        ["<leader>dr"] = {
            "<cmd>DapContinue<CR>",
            "Start or continue the debugger",
        },
    },
}

return M
