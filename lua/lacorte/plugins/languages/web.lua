return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        table.insert(opts.ensure_installed, { 'html', 'css' })
      end
    end,
  },
}
