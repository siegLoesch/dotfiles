--+-----------------------------------------------------------------------------
--|
--| @file:                  nvimConfs/nvimLspconfig/init.lua
--| @brief:                 Neovim builtin LSP configuration
--| @details:               Configured for filetypes:
--|                         C, C++, Lua, bash, vim, CMake, python
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 18:35:17
--| Last updated at:        2021-02-13 11:21:50
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------

--+-----------------------------------------------------------------------------
--|
--|                         Keybindings and completion
--|
--+-----------------------------------------------------------------------------
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	
	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	
	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
			hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
			hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
end


--+-----------------------------------------------------------------------------
--|
--|                              Setup for C, C++
--|
--+-----------------------------------------------------------------------------
-- SLO 20201124: showing errors with clangd
-- require'lspconfig'.clangd.setup{}
require'lspconfig'.ccls.setup{ on_attach = on_attach }

--+-----------------------------------------------------------------------------
--|
--|                                Setup for Lua
--|
--+-----------------------------------------------------------------------------
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_root_path = "/usr/share/lua-language-server"
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local sumneko_binary = "/usr/bin/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
	on_attach = on_attach;
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
}
--+-----------------------------------------------------------------------------
--|
--|                               Setup for bash
--|
--+-----------------------------------------------------------------------------
require'lspconfig'.bashls.setup{ on_attach = on_attach }

--+-----------------------------------------------------------------------------
--|
--|                              Setup for python
--|
--+-----------------------------------------------------------------------------
-- require'lspconfig'.pyls.setup{ on_attach = on_attach }
require'lspconfig'.jedi_language_server.setup{ on_attach = on_attach }

--+-----------------------------------------------------------------------------
--|
--|                              Setup for vimlsp
--|
--+-----------------------------------------------------------------------------
require'lspconfig'.vimls.setup{ on_attach = on_attach }

--+-----------------------------------------------------------------------------
--|
--|                       Setup for cmake language server
--|
--+-----------------------------------------------------------------------------
require'lspconfig'.cmake.setup{ on_attach = on_attach }

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = { "ccls", "sumneko_lua", "bashls", "jedi_language_server", "vimls", "cmake" }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup { on_attach = on_attach }
-- end
