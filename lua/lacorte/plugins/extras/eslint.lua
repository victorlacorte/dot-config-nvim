return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'eslint_d' })
      end
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      if type(opts.sources) == 'table' then
        local eslintd = require('none-ls.diagnostics.eslint_d')

        table.insert(opts.sources, eslintd)
      end
    end,
  },
}
