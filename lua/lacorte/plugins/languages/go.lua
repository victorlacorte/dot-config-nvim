return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gosum', 'gotmpl', 'gowork' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
        },
      },
    },
  },
}
