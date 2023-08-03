local status_ok, lsp = pcall(require, "lspconfig")
if not status_ok then
    return
end

lsp.clangd.setup {
    cmd = { "clangd", "--header-insertion=never", "--offset-encoding=utf-16" },
}

-- require "user.lsp.lsp-installer"
-- require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
