vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", function()
        require("telescope.builtin").lsp_references({ layout_strategy = "flex" })
      end, "[G]oto [R]eferences")
      nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("gD", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      nmap("<F12>", function()
        vim.cmd([[Telescope lsp_document_symbols]])
      end, "[D]ocument [S]ymbols")
      nmap("<S-F12>", function()
        vim.cmd([[Telescope lsp_workspace_symbols]])
      end, "[W]orkspace [S]ymbols")
      nmap("K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
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
    end,
  },
}
