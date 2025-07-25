local cmp_status_ok, cr = pcall(require, "code_runner")
if not cmp_status_ok then
  return
end

local python_cmd = ""
if vim.loop.os_uname().sysname == "Windows_NT" then
  -- Windows-specific configuration
  python_cmd = "python"
else
  -- Linux-specific configuration
  python_cmd = "python3 -u"
end

cr.setup({
  mode = "toggleterm",
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = python_cmd,
    typescript = "deno run",
    rust = "cd $dir && cargo run",
    lua = "love .",
    go = "cd $dir && go run $fileName",
  },
})
