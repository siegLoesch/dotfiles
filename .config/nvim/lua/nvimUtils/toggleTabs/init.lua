--+-----------------------------------------------------------------------------
--|
--| @file:                  nvimUtils/toggleTabs/init.lua
--| @brief:                 Defines tab character/space toggle function
--| @details:               Mapped to keys: 'tt'
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 17:00:14
--| @date: Last updated at: 2020-11-22 17:00:14
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
local M = {}

function M.toggleTabSpaces ()                                                   
| if not vim.bo.expandtab then                                                 
| | vim.bo.tabstop = 2        -- Width of a hard tabstop measured in "spaces"      
| | vim.o.tabstop = 2
| | vim.bo.shiftwidth = 2     -- Size of an "indent" also measured in spaces       
| | vim.o.shiftwidth = 2
| | vim.bo.expandtab = true   -- Always uses spaces instead of tab characters    
| | vim.o.expandtab = true
| | vim.bo.softtabstop = 0    --# of spaces a <Tab> counts for. If 0, featuer is off
| | vim.o.softtabstop = 0
| | vim.bo.autoindent = true  -- Copy indent from current line starting a new line
| | vim.o.autoindent = true
| else                                                                          
| | vim.bo.tabstop = 2        -- Width of a hard tabstop measured in "spaces"      
| | vim.o.tabstop = 2
| | vim.bo.shiftwidth = 2     -- Size of an "indent" also measured in spaces       
| | vim.o.shiftwidth = 2
| | vim.bo.expandtab = false  -- Always uses tab characters                     
| | vim.o.expandtab = false
| | vim.bo.autoindent = true  -- Copy indent from current line starting a new line
| | vim.o.autoindent = true
| end                                                                           
end

return M
