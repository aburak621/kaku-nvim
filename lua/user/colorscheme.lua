require("onedark").setup({
    style = "cool",
})

-- Disable italic comments
vim.cmd("highlight Comment gui=NONE")

-- Light or Dark mode
vim.o.background = "dark" -- Dark:
-- vim.o.background = "light" -- Light

-- AstroDark
-- vim.cmd([[colorscheme astrodark]])

-- Doom One
-- vim.cmd([[colorscheme doom-one]])

-- Catppuccin
vim.cmd([[colorscheme catppuccin-mocha]])
-- vim.cmd([[colorscheme catppuccin-latte]])

-- VSCode
-- vim.cmd([[colorscheme vscode]])

-- Gruvbox
-- vim.cmd [[colorscheme gruvbox]]

-- Lunaperche
-- vim.cmd [[colorscheme lunaperche]]

-- Flexoki
-- vim.cmd [[colorscheme flexoki]]
