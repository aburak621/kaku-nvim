local cmd = { 'ncat', '127.0.0.1', '6005' }
local pipe = [[\\.\pipe\godot]]

vim.lsp.start({
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
        vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
    end
})

-- Exec Flags command for Godot Editor (including "--")
--server "\\\\.\\pipe\\godot.pipe" --remote-send "<C-\><C-N>:lua vim.cmd([[n ]] .. sanitize_godot_path([[{file}]]))<CR>"

-- C:/tools/neovim/nvim-win64/bin/nvim.exe
-- --server "\\.\\pipe\\godot" --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"
--
-- vscode
-- C:/Users/Kakule/AppData/Local/Programs/Microsoft VS Code/Code.exe
-- {project} --goto {file}:{line}:{col}
