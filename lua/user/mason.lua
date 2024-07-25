require("mason").setup()
local servers = {
    "lua_ls",
    "clangd",
    "cmake",
    "pyright",
    "rust_analyzer",
    "taplo",
    "tsserver",
    "vimls",
    "jdtls",
    "cssls",
    "html",
    "jsonls",
    "marksman",
    "sqlls",
}
-- with_daps = { "cpptools", "debugpy" }

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = servers,
    -- with_daps = with_daps
})

local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", function() require('telescope.builtin').lsp_references({ layout_strategy = 'flex' }) end,
        "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<F12>", function() vim.cmd([[Telescope lsp_document_symbols]]) end, "[D]ocument [S]ymbols")
    nmap("<S-F12>", function() vim.cmd([[Telescope lsp_workspace_symbols]]) end, "[W]orkspace [S]ymbols")
    nmap("K", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end, "Hover (or Preview Fold)")

    vim.keymap.set("n", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })
    vim.keymap.set("i", "<C-p>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        { noremap = true, silent = true }
    )

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "clangd", "--header-insertion=never", "--offset-encoding=utf-16" },
        })
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                        telemetry = { enable = false },
                        library = {
                            "${3rd}/love2d/library"
                        }
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
    end,
})

vim.api.nvim_create_autocmd({ 'BufNew', 'BufEnter' }, {
    pattern = { '*.p8' },
    callback = function(args)
        vim.lsp.start({
            name = 'pico8-ls',
            cmd = { 'pico8-ls.cmd', '--stdio' },
            root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
            on_attach = on_attach,
        })
    end
})

-- NULL LS
require("user.null-ls")
