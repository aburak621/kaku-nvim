local status_ok, theme = pcall(require, "onedark")
if not status_ok then
	return
end

-- theme.setup({
	-- style = "darker",
-- })

vim.cmd([[
try
  colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
