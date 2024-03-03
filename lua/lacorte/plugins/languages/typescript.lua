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
        tsserver = {
          -- https://github.com/typescript-language-server/typescript-language-server#initializationoptions
          init_options = {
            hostInfo = 'neovim',
            plugins = {
              -- https://github.com/styled-components/typescript-styled-plugin
              {
                name = '@styled/typescript-styled-plugin',
                --location = '/opt/homebrew/lib/node_modules/@styled/typescript-styled-plugin/lib/index.js'
                location = '/Users/victor/.volta/tools/image/packages/@styled/typescript-styled-plugin/lib/node_modules/@styled/typescript-styled-plugin/lib/index.js',
              },
            },
          },
        },
      },
    },
  },
}
