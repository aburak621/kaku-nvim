local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "dap_repl",
    "gdscript",
    "godot_resource",
    "gitignore",
    "glsl",
    "hlsl",
    "html",
    "http",
    "java",
    "javascript",
    "json",
    "markdown",
    "lua",
    "python",
    "regex",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },                         -- "all" (parsers with maintainers), or a list of languages
  auto_install = true,
  sync_install = false,      -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" },   -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,        -- false will disable the whole extension
    disable = { "" },     -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = { disable = { "dart" } },
  indent = { enable = true, disable = { "yaml", "gdscript", "dart" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

-- Use zig for Neorg
require('nvim-treesitter.install').compilers = { "zig", vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl" }
