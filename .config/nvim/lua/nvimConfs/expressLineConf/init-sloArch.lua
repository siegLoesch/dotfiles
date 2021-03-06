--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Brief file description
--| @details:               Detailed file description
--| @author:                Siegfried Loesch
--| @date: Created at:      2020-12-08 20:30:33
--| @date: Last updated at: 2020-12-08 20:30:33
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------

-- Extensions:
local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')
local lsp_statusline = require('el.plugins.lsp_status')

local generator = function()
    local el_segments = {}

		-- local generator = function(_window, buffer)
		-- 	local el_segments = {}
		-- end
		-- require('el').setup({generator = generator})

    table.insert(el_segments, extensions.file_icon)

		-- print(builtin.filetype)
    table.insert(el_segments, builtin.filetype)

    -- Statusline options can be of several different types.
    -- Option 1, just a string.

    -- table.insert(el_segments, '[ls] ')

    -- Keep in mind, these can be the builtin strings,
    -- which are found in |:help statusline|
    -- table.insert(el_segments, '%f')

    -- expresss_line provides a helpful wrapper for these.
    -- You can check out el.builtin
    -- SLO local builtin = require('el.builtin')
    -- SLO local builtin = require('builtin')
    -- table.insert(el_segments, builtin.file) -- Abs path + filename
    table.insert(el_segments, builtin.tail_file)
    -- table.insert(el_segments, builtin.responsive_file)

    -- Option 3, returns a function that takes in a Window and a Buffer. See |:help el.Window| and |:help el.Buffer|
    --
    -- With this option, you don't have to worry about escaping / calling the function in the correct way to get the current buffer and window.
    local file_namer = function(_window, buffer)
      return buffer.name
    end
    -- table.insert(el_segments, file_namer)

    -- Option 2, just a function that returns a string.
    -- local extensions = require('el.extensions')
    table.insert(el_segments, extensions.mode) -- mode returns the current mode.

    -- Option 4, you can return a coroutine.
    --  In lua, you can cooperatively multi-thread.
    --  You can use `coroutine.yield()` to yield execution to another coroutine.
    --
    -- For example, in luvjob.nvim, there is `co_wait` which is a coroutine version of waiting for a job to complete. So you can start multiple jobs at once and wait for them to all be done.
    table.insert(el_segments, extensions.git_changes)

    -- Option 5, there are several helper functions provided to asynchronously
    --  run timers which update buffer or window variables at a certain frequency.
    --
    --  These can be used to set infrequrently updated values without waiting.
    local helper = require("el.helper")
    table.insert(el_segments, helper.async_buf_setter(
      win_id,
      'el_git_stat',
      extensions.git_changes,
      5000
    ))

		-- File Icon: depends on nvim-web-devicons
		-- table.insert(el_segments, subscribe.buf_autocmd(
		-- 	"el_file_icon",
		-- 	"BufRead",
		-- 	function(_, buffer)
		-- 		print("File icon = "..extensions.file_icon(_, buffer))
		-- 		return extensions.file_icon(_, buffer)
		-- 	end
		-- ))

    return el_segments
end

-- And then when you're all done, just call
require('el').setup { generator = generator }
