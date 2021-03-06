--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Brief file description
--| @details:               Detailed file description
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-12-08 20:09:00
--| @date: Last updated at: 2020-12-08 20:09:00
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
require'nvim-web-devicons'.setup {
	-- your personnal icons can go here (to override)
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			name = "Zsh"
		}
	};
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true;
}
