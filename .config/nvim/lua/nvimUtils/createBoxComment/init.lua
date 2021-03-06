--+-----------------------------------------------------------------------------
--|
--| @file:                  nvimUtils/createBoxComment/init.lua
--| @brief:                 Creates a box around text
--| @details:               Centers text inside the box. Vertical pad distance 
--|                         to text is one line. 
--|                         TODO: works correct for text inside one line.
--|                         Extend to block selected text
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 16:56:40
--| @date: Last updated at: 2020-11-22 16:56:40
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
--+-----------------------------------------------------------------------------
--|
--| Create a box around text.
--| Centers text inside the box.
--| Vertical pad distance to text is one line.
--| TODO: works correct for text inside one line. Extend to block selcted text
--|
--+-----------------------------------------------------------------------------
local M = {}

-- Put selected text into register " and get it from there
--SLO-- TODO: Alternative (better!!)
-- tostring(vim.api.nvim_get_current_line())
-- print(tostring(vim.api.nvim_get_current_line()))
local function getSelectedText ( )
  vim.api.nvim_command('normal! ""gvy')
  local selection = vim.api.nvim_call_function("getreg", {'"'})
  -- Function 'nvim_buf_set_lines' takes strings without newline only
  return string.gsub(selection, "\n", "")
end

local function setCommentPrefix ( )   -- Set box comment prefix
  local curBuf = vim.api.nvim_get_current_buf()
  -- Get the filetype
  local currentFiletype = vim.api.nvim_buf_get_option(curBuf, "ft")
  local commentPrefix = nil
  if currentFiletype == "cmake" or currentFiletype == "text" then
    commentPrefix = "#"
  elseif currentFiletype == "lua" then
    commentPrefix = "--"
  elseif currentFiletype == "vim" then
    commentPrefix = "\""
  elseif currentFiletype == "cpp" then
    commentPrefix = "//"
  else
    print("Prefix for current filetype <"..currentFiletype.."> not defined!")
    print("Please define.")
  end
  return commentPrefix
end

--|                 Get line number of current cursor position
local cursorLine = vim.api.nvim_win_get_cursor(0)[1]

local function setBoxLines( commentPrefix, selection ) -- Prepare box
  local tmpStringA = commentPrefix.."+"
  local tmpStringB = string.rep("-", 80-#commentPrefix-1)
  local boxLines = {}
  boxLines[1] = tmpStringA..tmpStringB
  boxLines[2] = commentPrefix.."|"
  tmpStringA = commentPrefix.."|"
  tmpStringB = string.rep(" ", math.floor(80-#commentPrefix-1-#selection)/2)
  boxLines[3] = tmpStringA..tmpStringB..selection
  boxLines[4] = boxLines[2]
  boxLines[5] = boxLines[1]
  return boxLines
end

function M.createBoxComment ()
  local selection = getSelectedText()
  local commentPrefix = setCommentPrefix()
  local boxLines = setBoxLines(commentPrefix, selection)
  vim.api.nvim_del_current_line() -- Delete current line (at cursor position)
  vim.api.nvim_put(boxLines, "l", false, false) -- Make box after the cursor
end

return M
