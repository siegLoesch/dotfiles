--+-----------------------------------------------------------------------------
--|
--| @file:                  userKeymaps/init.lua
--| @brief:                 Defines neovim key mappings
--| @details:               tno     --> Toggle 'number'
--|                         tnr     --> Toggle 'number' with 'relativenumber'
--|                         tt      --> Toggle tab character/space setting
--|                         cbo     --> Create a commented box around text
--|                         fhi     --> Insert a file header
--|                         fhu     --> Update a file header
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 16:44:26
--| Last updated at:        2020-12-23 17:03:00
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
local api = vim.api

--+-----------------------------------------------------------------------------
--|
--|                               Toggle 'number'
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "tno", "<cmd> set number! <CR>", {
  noremap = true;
})

--+-----------------------------------------------------------------------------
--|
--|               Toggle 'number' together with 'relativenumber'
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "tnr", "<cmd> set number! relativenumber!<CR>", {
  noremap = true;
})

-- Toggle tab settings (use lua long string that can be split over several
-- lines: [[ ... ]] )
api.nvim_set_keymap("n", "tt", "<cmd> luafile ~/.config/nvim/lua/nvimLuaScripts/toggleTabSpces.lua<CR>",{noremap= true,})
-- TODO: check alternative using luado
--api.nvim_set_keymap("n", "tt", "<cmd> luado
-- if not nvim.bo.expandtab then
--		print("expandtab before:"..vim.inspect(expandtab))
--		vim.bo.tabstop = 2
--		vim.bo.shiftwidth = 2
--		vim.bo.expandtab = true
--		vim.bo.softtabstop = 0
--		vim.bo.autoindent = true
--		print(vim.inspect(expandtab))
--		print("Using tab with spaces")
--	else
--		print("else expandtab before:"..vim.inspect(expandtab))
--		vim.bo.tabstop = 2
--		vim.bo.shiftwidth = 2
--		vim.bo.expandtab = false
--		vim.bo.autoindent = true
--		print(vim.inspect(expandtab))
--		print("Using tab character")
--	end
--end <CR>]], {noremap= true, silent = true})
-- TODO: check alternative require module
--SLO-20201122 "<cmd> lua require'nvimUtils/toggleTabs'.toggleTabSpaces()<CR>",

--+-----------------------------------------------------------------------------
--|
--|                     Create a commented box around text
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "cbo",
"<cmd> lua require'nvimUtils/createBoxComment'.createBoxComment()<CR>",
{noremap= true;})

--+-----------------------------------------------------------------------------
--|
--|                       Clear last search highlighting
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "<C-L>", "<cmd> :nohlsearch<CR><C-L>",{noremap= true;})

--+-----------------------------------------------------------------------------
--|
--|                            Nvim formatter format
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "<Leader>f", "<cmd> Format<CR>", {noremap=true;})

--+-----------------------------------------------------------------------------
--|
--|                                Clang format
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "<C-F>", "<cmd> pyf /usr/share/clang/clang-format.py<CR>",
	{noremap=true;})
api.nvim_set_keymap("i", "<C-F>", "<C-O> <cmd> pyf /usr/share/clang/clang-format.py<CR>",
	{noremap=true;})

--+-----------------------------------------------------------------------------
--|
--|                                Clang rename
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "<Leader>cr", "<cmd> py3f /opt/usr/share/clang/clang-rename.py<CR>", {noremap=true;})

--+-----------------------------------------------------------------------------
--|
--|                       Create or update a file header
--|
--+-----------------------------------------------------------------------------
api.nvim_set_keymap("n", "fhi", "<cmd> lua require'nvimTemplates/insertFileHeader'.insertHeaderLines()<CR>", {noremap= true;})
api.nvim_set_keymap("n", "fhu", "<cmd> lua require'nvimTemplates/insertFileHeader'.updateTime()<CR>", {noremap= true;})
