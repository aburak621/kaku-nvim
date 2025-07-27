-- semicolon.lua

-- Define a module table to hold the functions.
local M = {}

-- Define a function to check if a line ends with a specific character.
local function ends_with(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

-- Define the main function to handle semicolon placement.
function M.place_semicolon(punctuation)
  punctuation = punctuation or ";"
  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col(".")   -- Add 1 to get the character to the right of the cursor
  local line_len = #line

  -- Check if there is a closing parenthesis at the current position
  local char = line:sub(col, col)
  if char == ")" then
    -- If there is a closing parenthesis, insert the semicolon after it and move the cursor after the semicolon
    vim.api.nvim_put({ punctuation }, "c", true, true)
  else
    -- If there is no closing parenthesis, just insert a semicolon
    if line_len ~= col then
      vim.cmd("normal! h")
    end
    vim.api.nvim_put({ punctuation }, "c", true, true)
  end
end

return M
