--+-----------------------------------------------------------------------------
--|                                                                             
--|                          completion-nvim settings                           
--|                                                                             
--+-----------------------------------------------------------------------------
                                                                                
-- Use completion-nvim in every buffer                                          
-- TODO: use https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567
vim.api.nvim_command [[autocmd BufEnter * lua require'completion'.on_attach()]]
                                                                                
-- Use <Tab> and <S-Tab> to navigate through popup menu                         
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-N>" : "\\<Tab>"', {expr = true; noremap = true;} )
vim.api.nvim_set_keymap("i","<S-Tab>",'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"',{expr = true; noremap = true;} )

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.api.nvim_get_option('shortmess').."c"
                                                                                
-- Auto close popup menu when finish completion                                 
-- TODO: use https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567
-- SLO 20201122 vim.api.nvim_command [[autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif]]
                                                                                
-- Settings                                                                     
vim.g.completion_enable_auto_popup = 1       -- Enable auto popup
vim.g.completion_enable_snippet='v:null'     -- TODO: Enable snippets support
vim.g.completion_confirm_key  = "'\'<CR>"    -- Changing completion confirm key
vim.g.completion_enable_auto_hover = 1       -- Enable/Disable auto hover
vim.g.completion_enable_auto_signature = 1   -- Enable/Disable auto signature
vim.g.completion_sorting = "alphabet"        -- "length", "alphabet", "none"
vim.g.completion_matching_strategy_list = {'fuzzy'}      -- 'exact','substring','fuzzy','all'
--SLO-20201118 vim.g.completion_enable_in_comment=1       -- En-/Disable completion in comment
--SLO-20201118 vim.g.completion_trigger_character = [['.', '>', ':']] -- Trigger characters

-- Trigger Characters, Autocommand for different trigger characters for         
-- different languages.                                                         
--SLO-20201121 do_hook_autocmds {                                               
--SLO-20201121 "autocmd BufEnter * let g:completion_trigger_character = [['.']]";
--SLO-20201121 "autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = [['.', '>', ':']]"
--SLO-20201121 }
