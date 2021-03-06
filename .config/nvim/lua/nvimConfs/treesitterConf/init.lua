--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Configuration of nvim-treesitter
--| @details:               Detailed file description
--| @author:                Siegfried Loesch
--| @date: Created at:      2021-01-01 20:22:21
--| Last updated at:        2021-02-20 10:02:29
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
	-- one of "all", "maintained" (parsers with maintainers), or a list of
	-- languages
	ensure_installed = "maintained",
	highlight = {
		enable = true,              -- false will disable the whole extension
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight
			-- group.
			["foo.bar"] = "Identifier",
		},
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	rainbow = {
		enable = true
	},
	  -- list of language that will be disabled
	  -- disable = { "c", "rust" },
	  disable = { },
}
