local lsp = require 'lspconfig'
local utils = require 'utils'

utils.map('n', '<localleader>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.map('n', '<localleader>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
utils.map('n', '<localleader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
utils.map('n', '<localleader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', '<localleader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
utils.map('n', '<localleader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<localleader>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
utils.map('n', '<localleader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
utils.map('n', '<localleader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
utils.map('n', '<localleader>e', '<cmd>LspTroubleToggle<CR>')

lsp.metals.setup {}
lsp.pyright.setup {}
lsp.gopls.setup {}
lsp.texlab.setup {}
lsp.bashls.setup {}

-------------------------- lua ---------------------------------
local sumneko_lua_root = "/Users/thomaslaich/repos/lua-language-server"

lsp.sumneko_lua.setup {
  cmd = {
    sumneko_lua_root .. "/bin/macOS/lua-language-server", "-E",
    sumneko_lua_root .. "/main.lua"
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
}

-------------------------- typescript / javascript ---------------------------------
lsp.tsserver.setup {
  cmd = {
    'node',
    '/Users/thomaslaich/repos/typescript-language-server/server/lib/cli.js',
    '--stdio'
  },
  init_options = {
    document_formatting = false
  }
}

local eslint = {
  lintCommand = "node /Users/thomaslaich/repos/eslint_d.js/bin/eslint_d.js -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true
}

-- does not work if eslintConfig is in package.json
local function get_eslint_config_path()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then return eslintrc[0] end

  return vim.fn.getcwd()
end

lsp.efm.setup {
  init_options = {
    document_formatting = false
  },
  root_dir = get_eslint_config_path,
  settings = {
    rootMarkers = {".git/"},
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx", "typescript",
    "typescript.tsx", "typescriptreact"
  }
}

------------------- formatter ----------------------
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
    typescript = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    typescriptreact = {
      -- prettier
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'
          },
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
          exe = "lua-format",
          args = {"--indent-width=2"},
          stdin = true
        }
      end
    },
    cpp = {
      -- clang-format
      function()
        return {
          exe = "clang-format",
          args = {},
          stdin = true,
          cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
        }
      end
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx,*.rs,*.lua FormatWrite
augroup END
]], true)
