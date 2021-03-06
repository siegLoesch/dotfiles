--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Main neovim lua init file
--| @details:               Defines options, configurations, keymaps and utils
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-11-22 16:41:19
--| Last updated at:        2021-02-20 10:23:43
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
require('nvimOptions/userOptions')
require('nvimConfs/userConfs')
require('nvimUtils/nvimExternalUtils')
require('nvimKeymaps/userKeymaps')

-- Plugins
require('nvimConfs/lspConfig')
-- Change to nvim-compe for autocompletion on 20210220
-- require('nvimConfs/completionConf')
require('nvimConfs/compeConf')
require('nvimConfs/expressLineConf')
require('nvimConfs/nvimWebDevicons')
require('nvimConfs/formatterConf/init')
require('nvimConfs/treesitterConf')
require('nvimConfs/telescopeConf')
require('nvimConfs/lspSagaConf')

--SLO-2020118 popTerm = require 'nvim-popterm'
--SLO-2020118 config = popTerm.config
--SLO-2020118 mappings = popTerm.mappings
--SLO-2020118 popTerm.setup()

-- nvim-colorizer
--SLO-2020118 require 'colorizer'.setup()

-- file comments
--SLO-2020118 require 'luaTemplates'

-- File header updates
--SLO-2020118 require 'nvimConfig.autoCmds'

-- Snippets
--SLO-- snip = require 'snippet'
--SLO-- snipMappings = snip.snipMappings
--SLO-- local snippets = snip.snippets

-- USED
--SLO snippet = require'snippet'
--SLO snippet.setup()


--SLO-- vim.api.nvim_set_keymap("i", "<c-k>", "<cmd>lua return snip.expand_at_cursor()<CR>", {
--SLO--   noremap = true;
--SLO-- })
--SLO-- api.nvim_set_keymap("i", "<c-k>", "<cmd>lua return snippet.expand_at_cursor() or snippet.advance_snippet_variable(1) or snippet.finish_snippet()<CR>", {
--SLO--   noremap = true;
--SLO-- })
