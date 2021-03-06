-- This file can be loaded by calling `lua require('plugins')` from your 
-- init.vim

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
--SLO vim._update_package_paths()

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Simple plugins can be specified as strings
  --SLO use '9mm/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  --SLO use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  --SLO use {'andymass/vim-matchup', event = 'VimEnter *'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  --SLO use {
  --SLO   'w0rp/ale',
  --SLO   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --SLO   cmd = 'ALEEnable',
  --SLO   config = 'vim.cmd[[ALEEnable]]'
  --SLO }

  -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- Local plugins can be included
  --SLO use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  --SLO use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- You can specify multiple plugins in a single call
  --SLO use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  --SLO use {'dracula/vim', as = 'dracula'}
end)
