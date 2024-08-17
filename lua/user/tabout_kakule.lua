-- Define a function to move the cursor after a closing parenthesis
local chars = { ")", "]", "}", ">", '"', "'", "`" }

function stringInArray(str, arr)
    for _, value in ipairs(arr) do
        if value == str then
            return true
        end
    end
    return false
end

function tabout()
    local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    local char = string.sub(line, col, col)

    if stringInArray(char, chars) then
        vim.api.nvim_command("call feedkeys(\"\\<Right>\", 'n')")
    else
        vim.api.nvim_command("call feedkeys(\"\\<Tab>\", 'n')")
    end
end

-- Define an autocmd to trigger the function in insert mode when Tab is pressed
vim.cmd([[
    autocmd FileType * inoremap <expr> <Tab> luaeval('tabout()')
]])
