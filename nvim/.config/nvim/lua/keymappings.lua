local utils = require('utils')

utils.map('n', '<C-J>', '<C-W><C-J>')
utils.map('n', '<C-K>', '<C-W><C-K>')
utils.map('n', '<C-L>', '<C-W><C-L>')
utils.map('n', '<C-H>', '<C-W><C-H>')

utils.map('i', 'jj', '<Esc>') -- jj to escape

-------------------- fugitive -----------------------
utils.map('n', '<Leader>gs', '<cmd>G<CR>')
utils.map('n', '<Leader>gp', '<cmd>GPush<CR>')
utils.map('n', '<Leader>gd', '<cmd>Gvdiffsplit<CR>')
utils.map('n', '<Leader>gf', '<cmd>Fit fetch --all<CR>')
utils.map('n', '<Leader>grum', '<cmd>Grebase upstream/master<CR>')
utils.map('n', '<Leader>grom', '<cmd>Grebase origin/master<CR>')
utils.map('n', '<Leader>gdr', '<cmd>diffget //3<CR>')
utils.map('n', '<Leader>gdl', '<cmd>diffget //2<CR>')
-------------------- git-blame ---------------------
utils.map('n', '<leader>gt', "<cmd>GitBlameToggle<CR>")

---------------------- hop -------------------------
utils.map('n', '<leader>w', '<cmd>HopWord<CR>')

-------------------- nvim-tree ---------------------
utils.map('n', '<leader>n', '<cmd>lua require "nvim-tree".toggle()<CR>')

-------------------- telescope ---------------------
utils.map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>")
utils.map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>")
utils.map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>")
utils.map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>")

