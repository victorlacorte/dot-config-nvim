local util = require('lspconfig.util')

-- https://github.com/LazyVim/LazyVim/issues/1307#issuecomment-1710761980
local get_root_dir = function(fname)
  return util.root_pattern('tsconfig.base.json', 'package.json', '.git')(fname)
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'javascript', 'jsdoc', 'typescript', 'tsx' })
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
          -- https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md
          init_options = {
            hostInfo = 'neovim',
            plugins = {
              -- https://github.com/styled-components/typescript-styled-plugin
              {
                name = '@styled/typescript-styled-plugin',
                location = vim.fn.expand(
                  '$HOME/.volta/tools/image/packages/@styled/typescript-styled-plugin/lib/node_modules/@styled/typescript-styled-plugin/lib/index.js'
                ),
              },
            },
            maxTsServerMemory = 8192,
          },
          -- root_dir = get_root_dir,
        },
      },
    },
  },
}
