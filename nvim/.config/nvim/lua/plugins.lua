local utils = require('utils')
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- general language feature plugs
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
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
    end
  }
  use 'mhartington/formatter.nvim'

  -- general utilities
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-surround'
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function() require'hop'.setup() end
  }
  use {
    'terrortylor/nvim-comment',
    config = function() require('nvim_comment').setup() end
  }

  -- theming
  use 'folke/tokyonight.nvim'
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true
      }
    end
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'norcalli/nvim-colorizer.lua', -- highlight hex strings
    config = function() require('colorizer').setup() end
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('gitsigns').setup() end
  }
  use 'tpope/vim-fugitive'
  use 'f-person/git-blame.nvim'
  use 'kdheepak/lazygit.nvim'

  use {'lervag/vimtex', opt = true}

  -- GUI stuff
  use 'kyazdani42/nvim-tree.lua'
  use {'glepnir/galaxyline.nvim', branch = 'main'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
  }

  use {
    'akinsho/nvim-bufferline.lua',
    config = function()
      require('bufferline').setup {
        options = {numbers = 'buffer_id', diagnostics = 'nvim_lsp'}
      }
    end
  }
  use {
    'folke/trouble.nvim',
    config = function() require('trouble').setup {} end
  }
  use {
    'folke/which-key.nvim',
    config = function() require("which-key").setup {} end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require('packer').sync() end
end)

-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

------------------- colorscheme ---------------------
-- cmd 'colorscheme onedark'
g.tokyonight_style = "storm"
cmd [[colorscheme tokyonight]]

----------------- indent-blankline ------------------
vim.cmd([[
  let g:indent_blankline_show_current_context = v:true
]])
-- let g:indent_blankline_use_treesitter = v:true

require'nvim-tree'.setup()
