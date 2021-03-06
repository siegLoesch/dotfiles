--+-----------------------------------------------------------------------------
--|
--| @file:                  init.lua
--| @brief:                 Configuration of telescope.nvim
--| @details:               Using defaults for the moment
--| @author:                Siegfried Loesch
--| @date: Created at:      2021-01-02 08:53:43
--| @date: Last updated at: 2021-01-02 08:53:43
--| @version:               1.0.0
--| @copyright:             Distributed under the MIT License
--|                         See: http://opensource.org/licenses/MIT
--|
--+-----------------------------------------------------------------------------
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = ">",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      -- TODO add builtin options.
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    -- default { }, currently unsupported for shells like cmd.exe /
    -- powershell.exe
    set_env = { ['COLORTERM'] = 'truecolor' },
    -- For buffer previewer use 
    -- `require'telescope.previewers'.vim_buffer_cat.new`
    file_previewer = require'telescope.previewers'.cat.new,
    -- For buffer previewer use 
    -- `require'telescope.previewers'.vim_buffer_vimgrep.new`
    grep_previewer = require'telescope.previewers'.vimgrep.new,
    -- For buffer previewer use 
    -- `require'telescope.previewers'.vim_buffer_qflist.new`
    qflist_previewer = require'telescope.previewers'.qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

-- Key short cuts
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap=true;})
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {noremap=true;})
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>", {noremap=true;})
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", {noremap=true;})

