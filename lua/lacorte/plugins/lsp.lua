return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      { 'L3MON4D3/LuaSnip', version = '2.*', opts = {} },

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      'folke/lazydev.nvim',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- https://cmp.saghen.dev/
      keymap = {
        preset = 'default',
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, press `<C-space>` to toggle the documentation.
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 150,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },

    opts_extend = { 'sources.default' },
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    opts = {
      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- tsserver = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs'} },
        jsonls = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      },
    },
    config = function(_, opts)
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        --  To jump back, press <C-t>.
        nmap('<leader>gd', client.name ~= 'ts_ls' and require('telescope.builtin').lsp_definitions or function()
          local position_params = vim.lsp.util.make_position_params(0, 'utf-8')

          client:exec_cmd({
            command = '_typescript.goToSourceDefinition',
            arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
          })
        end, '[G]oto [D]efinition')

        --nmap('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        --nmap('<leader>gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        --nmap('<leader>D', require('telescope.builtin').lsp_type_definitions', 'Type [D]efinition')
        --nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        --nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, '[H]over Documentation')
        --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        --nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        --nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        --nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        --nmap('<leader>wl', function()
        --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, '[W]orkspace [L]ist Folders')
      end

      local servers = opts.servers

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local setup = function(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = on_attach,
          handlers = {
            ['workspace/executeCommand'] = function(_err, result, ctx, _config)
              if ctx.params.command ~= '_typescript.goToSourceDefinition' then
                return
              end

              if result == nil or #result == 0 then
                -- Fallback to lookup for a type definition
                require('telescope.builtin').lsp_definitions()
                return
              end

              -- vim.lsp.util.jump_to_location(result[1], 'utf-8')
              vim.lsp.util.show_document(result[1], 'utf-8', { focus = true })
            end,
          },
        }, servers[server] or {})

        require('lspconfig')[server].setup(server_opts)
      end

      local mslp = require('mason-lspconfig')

      local ensure_installed = {}
      local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      mslp.setup({
        ensure_installed = ensure_installed,
        handlers = { setup },
      })
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
        -- "flake8",
      },
    },

    config = function(_, opts)
      require('mason').setup(opts)

      local mr = require('mason-registry')

      local ensure_installed = function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    -- Copied from LazyVim/lua/lazyvim/util/plugin.lua
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'mason.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    opts = function()
      local nls = require('null-ls')

      return {
        root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
        sources = {
          --nls.builtins.formatting.fish_indent,
          --nls.builtins.diagnostics.fish,
          --nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
        },
      }
    end,
  },
}
