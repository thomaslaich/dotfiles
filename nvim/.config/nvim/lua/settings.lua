local utils = require'utils'

local indent = 2

utils.opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
utils.opt('b', 'shiftwidth', indent)                        -- Size of an indent
utils.opt('b', 'smartindent', true)                         -- Insert indents automatically
utils.opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options
utils.opt('o', 'hidden', true)                              -- Enable modified buffers in background
utils.opt('o', 'ignorecase', true)                          -- Ignore case
utils.opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
utils.opt('o', 'scrolloff', 4 )                             -- Lines of context
utils.opt('o', 'shiftround', true)                          -- Round indent
utils.opt('o', 'sidescrolloff', 8 )                         -- Columns of context
utils.opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
utils.opt('o', 'splitbelow', true)                          -- Put new windows below current
utils.opt('o', 'splitright', true)                          -- Put new windows right of current
utils.opt('o', 'termguicolors', true)                       -- True color support
utils.opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
utils.opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
utils.opt('w', 'number', true)                              -- Print line number
--utils.opt('w', 'relativenumber', true)                      -- Relative line numbers
utils.opt('w', 'wrap', false)                               -- Disable line wrap
