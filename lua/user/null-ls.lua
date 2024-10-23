local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- Web
    formatting.prettier.with({
      filetypes = {
        "html",
        "css",
        "json",
        "markdown",
        "javascript",
        -- "typescript",
        -- "typescriptreact",
        -- "yaml",
        -- "vue",
        -- "scss",
        -- "less",
        -- "jsonc",
        -- "graphql",
        -- "handlebars",
      },
      extra_args = { "--semi", "--single-quote", "--jsx-single-quote" },
    }),
    -- formatting.rustfmt,
    -- Python
    -- formatting.black,
    -- diagnostics.flake8,
    -- diagnostics.pylint,
    -- Lua
    formatting.stylua.with({
      args = { "--indent-type", "Spaces" },
    }),
    formatting.clang_format.with({
      extra_args = { "--style=Microsoft" },
    }),
    formatting.gdformat,
  },
})
