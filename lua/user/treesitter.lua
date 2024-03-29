local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- require("nvim-ts-autotag").setup()

configs.setup({
	ensure_installed = {
		"c",
		"c_sharp",
		"cmake",
		"comment",
		"cpp",
		"css",
		"gitignore",
		"glsl",
		"hlsl",
		"html",
		"http",
		"java",
		"javascript",
		"json",
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
	}, -- "all" (parsers with maintainers), or a list of languages
	auto_install = true,
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
