-- Rather than flat map here, properly extend on individual configs
local function flat_map(tbl, fn)
  local result = {}

  for _, v in ipairs(tbl) do
    local mapped = fn(v)

    if type(mapped) == 'table' then
      for _, mv in ipairs(mapped) do
        table.insert(result, mv)
      end
    else
      table.insert(result, mapped)
    end
  end

  return result
end

return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSUpdateSync' },
    opts = {
      ensure_installed = {
        'bash',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'yaml',
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        local added = {}

        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end

          added[lang] = true

          return true
        end, opts.ensure_installed)
      end

      opts.ensure_installed = flat_map(opts.ensure_installed, function(v)
        return v
      end)
      -- print(vim.inspect(opts.ensure_installed))

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
