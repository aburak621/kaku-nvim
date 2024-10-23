local status_ok, MiniFiles = pcall(require, "mini.files")
if not status_ok then
  return
end

local open_file = function(path)
  open_in_external_editor(MiniFiles.get_fs_entry().path)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    vim.keymap.set('n', '<S-s>', open_file, { buffer = args.data.buf_id })
    vim.keymap.set('n', '<Tab>', '', { buffer = args.data.buf_id })
    vim.keymap.set('n', '<S-Tab>', '', { buffer = args.data.buf_id })
  end,
})

function open_in_external_editor(file_path)
  local cmd, args = "", {}

  if vim.fn.has("win32") == 1 then
    cmd = "cmd"
    args = { "/c", "start", '""', file_path }
  elseif vim.fn.has("macunix") == 1 then
    cmd = "open"
    args = { file_path }
  elseif vim.fn.has("unix") == 1 then
    cmd = "xdg-open"
    args = { file_path }
  else
    vim.notify("Unsupported platform", vim.log.levels.WARN)
    return
  end

  local handle = vim.loop.spawn(cmd, { args = args, detached = true }, function(code)
    if code ~= 0 then
      vim.notify("Failed to open file", vim.log.levels.WARN)
    end
  end)

  if not handle then
    vim.notify("Failed to spawn command", vim.log.levels.WARN)
  end
end
