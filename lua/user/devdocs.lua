local status_ok, devdocs = pcall(require, "nvim-devdocs")
if not status_ok then
	return
end

devdocs.setup({
	dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
	telescope = {}, -- passed to the telescope picker
	float_win = { -- passed to nvim_open_win(), see :h api-floatwin
		relative = "editor",
		height = 25,
		width = 100,
		border = "rounded",
	},
	wrap = false, -- text wrap, only applies to floating window
	previewer_cmd = "glow", -- for example: "glow"
	cmd_args = { "-s", "dark", "-w", "80" }, -- example using glow: { "-s", "dark", "-w", "80" }
	cmd_ignore = {}, -- ignore cmd rendering for the listed docs
	picker_cmd = "glow", -- use cmd previewer in picker preview
	picker_cmd_args = { "-p" }, -- example using glow: { "-p" }
	ensure_installed = {}, -- get automatically installed
	after_open = function(bufnr) end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
})
