--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Setup file for nvim formatter
--| @details:               Detailed file description
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-12-12 19:12:02
--| @date: Last updated at: 2020-12-12 19:12:02
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
		python = {
			-- python-black
			function()
				return {
					exe = "black",
					args = {"--line-length", 79, "--target-version", "py39"},
					stdin = true
				}
			end
		}
  }
})
