local M = {}

function M.find_workspace_folder()
    -- Get the current buffer's full path
    local current_buf = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    if current_buf == "" then
        return nil
    end

    -- Get the list of workspace folders
    local workspace_folders = vim.lsp.buf.list_workspace_folders()
    if not workspace_folders or #workspace_folders == 0 then
        return nil
    end

    local function is_subpath(subpath, basepath)
        -- Use vim's path functions for more robust path handling
        local norm_subpath = vim.fs.normalize(subpath):lower()
        local norm_basepath = vim.fs.normalize(basepath):lower()

        return vim.startswith(norm_subpath, norm_basepath)
    end

    -- Find the most specific (longest) workspace folder containing the buffer
    local longest_match = nil
    local max_length = 0

    for _, folder in ipairs(workspace_folders) do
        if is_subpath(current_buf, folder) then
            local folder_length = #vim.fs.normalize(folder)
            if folder_length > max_length then
                longest_match = folder
                max_length = folder_length
            end
        end
    end

    return longest_match
end

return M
