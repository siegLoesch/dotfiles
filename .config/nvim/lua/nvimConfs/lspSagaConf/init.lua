--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 LspSaga configuration
--| @details:               according to:
--|                         https://github.com/glepnir/lspsaga.nvim
--| @author:                Siegfried Loesch
--| @date: Created at:      2021-02-26 10:13:47
--| Last updated at:        2021-02-27 08:52:19
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
--+-----------------------------------------------------------------------------
--|
--|                            lspsaga.nvim settings
--|
--+-----------------------------------------------------------------------------
local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_keys = { quit = 'q',exec = '<CR>' }
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
-- border_style = 1
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

-- saga.init_lsp_saga {
--   your custom option here
-- }

-- or --use default config
saga.init_lsp_saga()

-- local nnoremap = vim.keymap.nnoremap

-- Keymaps
-- lsp provider to find the cursor word definition and reference
vim.api.nvim_set_keymap("n", "gh",
"<cmd> lua require'lspsaga.provider'.lsp_finder()<CR>",
{noremap= true;silent=true})
-- nnoremap { 'gh', require'lspsaga.provider'.lsp_finder() }

-- code action
vim.api.nvim_set_keymap("n", "<leader>ca",
"<cmd> lua require('lspsaga.codeaction').code_action()<CR>",
{noremap= true;silent=true})
vim.api.nvim_set_keymap("v", "<leader>ca",
"<cmd><,'>lua require('lspsaga.codeaction').range_code_action()<CR>",
{noremap= true;silent=true})

-- show hover doc
vim.api.nvim_set_keymap("n", "K",
"<cmd> lua require('lspsaga.hover').render_hover_doc()<CR>",
{noremap= true;silent=true})
-- scroll down hover doc or scroll in definition preview
vim.api.nvim_set_keymap("n", "C-f",
"<cmd> lua require('lspsaga.action').smart_scroll_with_saga()<CR>",
{noremap= true;silent=true})

-- show signature help
vim.api.nvim_set_keymap("n", "gs",
"<cmd> lua require('lspsaga.signaturehelp').signature_help()<CR>",
{noremap= true;silent=true})

-- rename
vim.api.nvim_set_keymap("n", "gr",
"<cmd> lua require('lspsaga.rename').rename()<CR>",
{noremap= true;silent=true})

-- preview definition
vim.api.nvim_set_keymap("n", "gd",
"<cmd> lua require'lspsaga.provider'.preview_definition()<CR>",
{noremap= true;silent=true})

-- Jump Diagnostic and Show Diagnostics
-- show
vim.api.nvim_set_keymap("n", "<leader>cd",
"<cmd> lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>",
{noremap= true;silent=true})
-- jump diagnostic
vim.api.nvim_set_keymap("n", "[e",
"<cmd> lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
{noremap= true;silent=true})
vim.api.nvim_set_keymap("n", "]e",
"<cmd> lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
{noremap= true;silent=true})

-- float terminal also you can pass the cli command in open_float_terminal
-- function:
vim.api.nvim_set_keymap("n", "A-d",
"<cmd> lua require('lspsaga.floaterm').open_float_terminal()<CR>",
{noremap= true;silent=true}) -- or open_float_terminal('lazygit')<CR> 
-- vim.api.nvim_set_keymap("n", "A-d <C-\><C-n>",
-- "<cmd> lua require('lspsaga.floaterm').close_float_term()<CR>",
-- {noremap= true;silent=true})
