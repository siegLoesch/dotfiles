--+-----------------------------------------------------------------------------
--|
--| @file:                  nvimOptions/userOptions/init.lua
--| @brief:                 Sets neovim global, buffer and window options
--| @details:               WIP
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 16:52:52
--| @date: Last updated at: 2020-11-22 16:52:52
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
--+-----------------------------------------------------------------------------
--|
--|                    vim.o.$option: Sets global options
--|
--+-----------------------------------------------------------------------------
vim.o.listchars = 'tab:| ' -- Char set for tab indents
vim.o.title = true         -- Change terminal's title to filename [+=-] (path)
                           -- Or set 'titlestring'
vim.o.showmatch = true     -- Highlight matching bracket
vim.o.inccommand = "split" -- Dynamic substitution highlite
vim.o.pumblend = 20        -- Transparent background for pum
vim.o.wildoptions = "pum"  -- Show completion matches in pum
vim.o.termguicolors = true -- Enables 24-bit RGB color in the TUI

--+-----------------------------------------------------------------------------
--|
--|                 vim.bo.$varName: Sets buffer local options
--|
--+-----------------------------------------------------------------------------
vim.bo.fileencoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.bo.textwidth = 78
vim.o.textwidth = 78
vim.bo.smartindent = true
vim.o.smartindent = true
-- Tabs and indents
vim.bo.tabstop = 2        -- Width of a hard tabstop measured in "spaces"
vim.o.tabstop = 2
vim.bo.shiftwidth = 2     -- Size of an "indent" also measured in spaces
vim.o.shiftwidth = 2
vim.bo.expandtab = false  -- Always uses tab characters
vim.o.expandtab = false
vim.bo.autoindent = true  -- Copy indent from current line starting a new line
vim.o.autoindent = true

--+-----------------------------------------------------------------------------
--|
--|                 vim.wo.$option: Sets a local window option
--|
--+-----------------------------------------------------------------------------
vim.wo.list = true            -- Show tabs as CTRL-I is displayed
vim.wo.colorcolumn = "80"
