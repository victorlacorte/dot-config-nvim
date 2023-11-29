-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set(
  'n',
  'k',
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  'n',
  'j',
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Split window
vim.keymap.set(
  'n',
  '<leader>ss',
  ':split<CR><C-w>w',
  { desc = '[S]plit horizontally' }
)
vim.keymap.set(
  'n',
  '<leader>sv',
  ':vsplit<CR><C-w>w',
  { desc = '[S]plit [v]ertically' }
)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
  vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  { desc = 'Go to previous diagnostic message' }
)
vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  { desc = 'Go to next diagnostic message' }
)
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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
      return client.name ~= 'tsserver'
    end,
  })
end, { desc = '[F]ormat' })

vim.keymap.set(
  'n',
  '<Leader>u',
  ':UndotreeToggle<CR>',
  { desc = 'Toggle [U]ndoTree' }
)
