function sanitize_godot_path(path)
    local out_path = string.gsub(path, [[/]], [[\\]])
    out_path = string.gsub(out_path, [[ ]], [[\ ]])
    return out_path
end

local M = {}

local workspace_finder = require('user.workspace_finder')

function M.setup()
    vim.api.nvim_command("augroup ChangeCwdPlugin")
    vim.api.nvim_command("autocmd!")
    vim.api.nvim_command("autocmd BufEnter * lua require('user.change_cwd_plugin').change_cwd()")
    vim.api.nvim_command("augroup END")
end

function M.change_cwd()
    -- Get the buffer type (buftype)
    local buftype = vim.bo.buftype

    -- Check if the buffer type is not empty and not one of the excluded types
    if buftype == "" then
        local workspace_folder = workspace_finder.find_workspace_folder()

        if workspace_folder then
            vim.api.nvim_command("lcd " .. workspace_folder)
        else
            -- If no workspace folder found, default to current file's directory
            local current_file_path = vim.fn.expand("%:p:h")
            vim.api.nvim_command("lcd " .. current_file_path)
        end
    end
end

M.setup()

return M
