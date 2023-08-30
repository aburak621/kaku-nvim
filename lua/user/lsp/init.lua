local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

lspconfig.clangd.setup {
    cmd = { "clangd", "--header-insertion=never", "--offset-encoding=utf-16" },
}

lspconfig.csharp_ls.setup {}

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}

-- require "user.lsp.lsp-installer"
-- require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
