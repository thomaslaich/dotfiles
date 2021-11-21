local utils = require('utils')
local cmd = vim.cmd
local g = vim.g

cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function

paq'savq/paq-nvim';                  -- Let Paq manage itself

-- general language feature plugs
paq'neovim/nvim-lspconfig'
paq'hrsh7th/nvim-compe'
paq'hrsh7th/vim-vsnip'
paq'hrsh7th/vim-vsnip-integ'
paq'nvim-treesitter/nvim-treesitter'
-- paq'mhartington/formatter.nvim'

-- general utilities
paq'terryma/vim-multiple-cursors'
paq'tpope/vim-surround'
paq{'phaazon/hop.nvim', as='hop'}
paq'terrortylor/nvim-comment'

-- theming
paq'folke/tokyonight.nvim'
paq'kyazdani42/nvim-web-devicons'
paq'lukas-reineke/indent-blankline.nvim'
paq'norcalli/nvim-colorizer.lua'    -- highlight hex strings

-- Git
paq'lewis6991/gitsigns.nvim'
paq'tpope/vim-fugitive'
paq'f-person/git-blame.nvim'
paq'kdheepak/lazygit.nvim'

paq{'lervag/vimtex', opt=true}

-- GUI stuff
paq'kyazdani42/nvim-tree.lua'
paq{'glepnir/galaxyline.nvim', branch='main'}
paq'nvim-lua/popup.nvim' -- required for telescope
paq'nvim-lua/plenary.nvim' -- required for telescope
paq'nvim-telescope/telescope.nvim'
paq'akinsho/nvim-bufferline.lua'
paq'folke/trouble.nvim'
paq'folke/which-key.nvim'

------------------- colorizer -----------------------
require'colorizer'.setup()


------------------- colorscheme ---------------------
-- cmd 'colorscheme onedark'
g.tokyonight_style = "storm"
cmd[[colorscheme tokyonight]]

--------------------- compe -------------------------
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    snippets_nvim = true,
    treesitter = true,
    vim_dadbod_completion = true
  };
}

-------------------- devicons -----------------------
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

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


-------------------- gitsigns -----------------------
require'gitsigns'.setup()

---------------------- hop --------------------------
require'hop'.setup()

utils.map('n', '<leader>w', '<cmd>HopWord<CR>')

----------------- indent-blankline ------------------
vim.cmd([[
  let g:indent_blankline_show_current_context = v:true
]])
-- let g:indent_blankline_use_treesitter = v:true

-------------------- bufferline ---------------------
require('bufferline').setup{
  options = {
    numbers = 'buffer_id',
    diagnostics = 'nvim_lsp',
  }
}

-------------------- nvim-tree ----------------------
require'nvim-tree'.setup {}
utils.map('n', '<leader>n', '<cmd>lua require "nvim-tree".toggle()<CR>')

--------------------- telescope ---------------------
utils.map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>")
utils.map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>")
utils.map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>")
utils.map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>")


-------------------- treesitter ---------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {} -- list of language that will be disabled
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    rainbow = {enable = true},
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim 
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    }
}

------------------ nvim-trouble --------------------
require('trouble').setup {}

------------------- which-key ----------------------
require("which-key").setup {}

------------------ nvim-comment --------------------
require('nvim_comment').setup()

