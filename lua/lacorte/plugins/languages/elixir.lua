return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, { 'elixir', 'heex', 'eex' })
      end
    end,
  },
  --{
  --  'williamboman/mason.nvim',
  --  opts = function(_, opts)
  --    if type(opts.ensure_installed) == 'table' then
  --      vim.list_extend(opts.ensure_installed, { 'elixir-ls' })
  --    end
  --  end,
  --},
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        elixirls = {
          --https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#elixirls
        },
      },
    },
  },
}
