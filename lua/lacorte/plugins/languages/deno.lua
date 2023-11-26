return {
  {
    -- NOTE installing this will cause issues with tsserver
    --'williamboman/mason.nvim',
    --opts = function(_, opts)
    --  if type(opts.ensure_installed) == 'table' then
    --    vim.list_extend(opts.ensure_installed, { 'deno' })
    --  end
    --end,
  },
  {
    --'jose-elias-alvarez/null-ls.nvim',
    --opts = function(_, opts)
    --  if type(opts.sources) == 'table' then
    --    local nls = require 'null-ls'

    --    table.insert(
    --      opts.sources,
    --      nls.builtins.formatting.deno_fmt.with {
    --        filetypes = { 'markdown' },
    --      }
    --    )
    --  end
    --end,
  },
}
