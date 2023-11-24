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

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
if has 'macunix' then
  vim.opt.clipboard:append { 'unnamedplus' }
end

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
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
if has 'macunix' then
  vim.g.netrw_keepdir = 0
end

vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0

vim.o.scrolloff = 8

-- Having longer updatetime (default is 4,000ms) leads to noticeable delays and
-- poor user experience.
vim.o.updatetime = 50

-- Folding: https://github.com/nvim-treesitter/nvim-treesitter#folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false
