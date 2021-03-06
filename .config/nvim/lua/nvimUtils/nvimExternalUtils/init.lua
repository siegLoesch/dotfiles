local nvim = require 'nvimUtils/nvimExternalUtils/nvim'

-- TODO: check if definition of <Leader> key possible via standard means
-- see: :help mapleader, :echo mapleader, :let mapleader
-- vim.g.mapleader = "\<Space>"
-- nvim.g.mapleader = "\\<space>"                                               
-- nvim.g.mapleader = "<Space>"
vim.api.nvim_command [[map <Space> <Leader>]]
