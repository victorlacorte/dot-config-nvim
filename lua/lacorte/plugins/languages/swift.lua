return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, { 'swift' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sourcekit
        sourcekit = {},
      },
    },
  },
}
