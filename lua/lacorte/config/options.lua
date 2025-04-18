local has = function(x)
  return vim.fn.has(x) == 1
end

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.swapfile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Netrw
-- When moving files on linux and macOS across different directories it is necessary to set g:netrw_keepdir to zero
-- TODO create file in the current working directory
-- TODO recursively remove non-empty directories
if has('macunix') then
  vim.g.netrw_keepdir = 0
end

vim.g.netrw_banner = 0

vim.o.scrolloff = 8

-- Having longer updatetime (default is 4,000ms) leads to noticeable delays and
-- poor user experience.
vim.o.updatetime = 50

-- Folding: https://github.com/nvim-treesitter/nvim-treesitter#folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldenable = false

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()

      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
vim.api.nvim_create_autocmd('LspDetach', { command = 'setl foldexpr<' })

-- Does not work
-- vim.o.winborder = 'rounded'
