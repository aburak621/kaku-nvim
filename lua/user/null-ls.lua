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
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		-- Web
		formatting.prettier.with({
			filetypes = {
				"javascript",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"graphql",
				"handlebars",
			},
			extra_args = { "--no-semi" },
		}),
		formatting.rustfmt,
		-- Python
		-- formatting.black,
		-- diagnostics.flake8,
		-- diagnostics.pylint,
		-- Lua
		formatting.stylua,
		formatting.clang_format.with({
			extra_args = { "--style=Microsoft" },
		}),
	},
})
