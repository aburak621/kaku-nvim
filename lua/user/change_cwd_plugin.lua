local M = {}

local workspace_finder = require('user.workspace_finder')

local function find_git_root()
    local current_dir = vim.fn.expand("%:p:h")
    local git_dir = vim.fn.finddir('.git', current_dir .. ';')

    if git_dir and git_dir ~= "" then
        return vim.fn.fnamemodify(git_dir, ":h")
    end
    return nil
end

local function safe_change_dir(path)
    if not path then return false end

    local ok, err = pcall(vim.cmd, "lcd " .. path)
    if not ok then
        return false
    end
    return true
end

function M.change_cwd()
    -- Only process normal buffers
    if vim.bo.buftype ~= "" then return end

    local git_root = find_git_root()
    if git_root then
        -- Skip non-file buffers (like Diffview)
        if git_root:find("://") then return end
        if safe_change_dir(git_root) then return end
    end

    -- Try workspace folder if no git root
    local workspace_folder = workspace_finder.find_workspace_folder()
    if workspace_folder and safe_change_dir(workspace_folder) then
        return
    end

    -- Fall back to current file's directory
    safe_change_dir(vim.fn.expand("%:p:h"))
end

function M.setup()
    vim.api.nvim_create_augroup("ChangeCwdPlugin", { clear = true })
    vim.api.nvim_create_autocmd("BufEnter", {
        group = "ChangeCwdPlugin",
        callback = M.change_cwd,
    })
end

M.setup()

return M
