return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, { 'javascript', 'jsdoc', 'typescript', 'tsx' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ts_ls = {
          -- https://github.com/typescript-language-server/typescript-language-server#initializationoptions
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
          init_options = {
            hostInfo = 'neovim',
            plugins = {
              -- https://github.com/styled-components/typescript-styled-plugin
              {
                name = '@styled/typescript-styled-plugin',
                --location = '/opt/homebrew/lib/node_modules/@styled/typescript-styled-plugin/lib/index.js'
                location = vim.fn.expand(
                  '$HOME/.volta/tools/image/packages/@styled/typescript-styled-plugin/lib/node_modules/@styled/typescript-styled-plugin/lib/index.js'
                ),
              },
            },
          },
        },
      },
    },
  },
}
