-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Split window
vim.keymap.set('n', '<leader>ss', ':split<CR><C-w>w', { desc = '[S]plit horizontally' })
vim.keymap.set('n', '<leader>sv', ':vsplit<CR><C-w>w', { desc = '[S]plit [v]ertically' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trim trailing whitespace when yanking text.
-- The main motivator for this is pasting into Telescope boxes (e.g. "Git files", "Live grep") from the shared OS clipboard.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Trim final newline character',
  group = vim.api.nvim_create_augroup('kickstart-trim-on-yank', { clear = true }),
  callback = function()
    if vim.v.event.operator == 'y' then
      vim.fn.setreg('+', vim.fn.trim(vim.fn.getreg('+')))
    end
  end,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>pv', function()
  vim.cmd('Explore')
end, { desc = 'Toggle Netrw' })

-- Don't yank with x
vim.keymap.set('n', 'x', '"_x')

-- Navigate the quickfix's content more easily
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')

-- Allow moving highlighted content up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= 'ts_ls'
    end,
  })
end, { desc = '[F]ormat' })

vim.keymap.set('n', '<Leader>u', ':UndotreeToggle<CR>', { desc = 'Toggle [U]ndoTree' })
