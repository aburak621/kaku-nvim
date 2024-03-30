local M = {}

function M.find_workspace_folder()
    -- Get the current working directory of the buffer
    local current_buf = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

    -- Get the list of workspace folders
    local workspace_folders = vim.lsp.buf.list_workspace_folders()

    -- Initialize a variable to store the workspace folder containing the buffer
    local buffer_workspace_folder = nil

    local function is_subpath(subpath, basepath)
        -- Normalize paths by removing trailing slashes and converting slashes to the same type
        subpath = subpath:gsub("[/\\]*$", ""):gsub("\\", "/"):lower()
        basepath = basepath:gsub("[/\\]*$", ""):gsub("\\", "/"):lower()

        -- Check if the subpath starts with the basepath
        return subpath:find("^" .. basepath .. "/") ~= nil
    end

    -- Iterate through the workspace folders
    for _, folder in ipairs(workspace_folders) do
        if not string.find(folder, "\\") then
            -- Check if the current working directory is within the workspace folder
            if is_subpath(current_buf, folder) then
                buffer_workspace_folder = folder
                break
            end
        end
    end

    -- Return the workspace folder containing the buffer
    return buffer_workspace_folder
end

return M
