return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'prettierd' })
      end
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      if type(opts.sources) == 'table' then
        local nls = require('null-ls')

        table.insert(
          opts.sources,
          nls.builtins.formatting.prettierd.with({
            disabled_filetypes = { 'yaml' },
            prefer_local = 'node_modules/.bin',
          })
        )
      end
    end,
  },
}
