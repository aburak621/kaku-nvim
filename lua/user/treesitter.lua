local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local install = require("nvim-treesitter.install")
install.prefer_git = true
install.compilers = { "zig", vim.fn.getenv("CC"), "cc", "gcc", "clang", "cl" }

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- Enable Highlighting
    pcall(vim.treesitter.start, args.buf)

    local ft = vim.bo[args.buf].filetype
    local indent_disabled = { yaml = true, gdscript = true, dart = true }

    if not indent_disabled[ft] then
      vim.bo[args.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
    end
  end,
})
