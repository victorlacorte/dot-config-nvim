local is_git_repo = function()
  vim.fn.system 'git rev-parse --is-inside-work-tree'

  return vim.v.shell_error == 0
end

local get_git_root = function()
  local dot_git_path = vim.fn.finddir('.git', '.;')

  return vim.fn.fnamemodify(dot_git_path, ':h')
end

local get_cwd = function()
  if is_git_repo() then
    return get_git_root()
  else
    return vim.fn.getcwd()
  end
end

return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },

    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },

    keys = {
      {
        '<leader>?',
        function()
          require('telescope.builtin').oldfiles()
        end,
        mode = 'n',
        desc = '[?] Find recently opened files',
      },
      {
        '<leader><space>',
        function()
          require('telescope.builtin').buffers { path_display = { 'truncate' } }
        end,
        mode = 'n',
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader>/',
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        mode = 'n',
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        '<leader>sf',
        function()
          local opts = { path_display = { 'truncate' } }

          if is_git_repo() then
            require('telescope.builtin').git_files(opts)
            return
          end

          require('telescope.builtin').find_files(opts)
        end,
        mode = 'n',
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sh',
        function()
          require('telescope.builtin').help_tags()
        end,
        mode = 'n',
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string { path_display = { 'truncate' }, cwd = get_cwd() }
        end,
        mode = 'n',
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>sg',
        function()
          require('telescope.builtin').live_grep()
        end,
        mode = 'n',
        desc = '[S]earch by [G]rep',
      },

      {
        '<leader>sd',
        function()
          require('telescope.builtin').diagnostics()
        end,
        mode = 'n',
        desc = '[S]earch [D]iagnostics',
      },
    },

    config = function()
      -- Enable telescope fzf native, if installed
      require('telescope').load_extension 'fzf'
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
