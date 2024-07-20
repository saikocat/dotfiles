local keymap = vim.keymap

-- set leader key to Space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- copy/paste to system clipboard
keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { desc = 'Yank to system clipboard' })
-- keymap.set('n', '<Leader>d', '"+d', { desc = 'Cut to system clipboard' })
keymap.set('n', '<Leader>p', '"+p', { desc = 'Put from system clipboard' })
keymap.set('n', '<Leader>P', '"+P', { desc = 'Put from system clipboard' })

-- window management
keymap.set('n', '<Leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<Leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<Leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap.set('n', '<Leader>sx', '<Cmd>close<CR>', { desc = 'Close current split' })

-- diagnostics
-- <Cmd>lua vim.diagnostic.goto_next()<CR>
keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- remove highlight
keymap.set('n', '<Leader><Esc>', '<Cmd>noh<CR>', { desc = 'Remove highlight' })

-- number column management
keymap.set('n', '<Leader>nn', '<Cmd>set number!<CR>', { desc = 'Toggle line number' })
keymap.set('n', '<Leader>nr', '<Cmd>set relativenumber!<CR>', { desc = 'Toggle relative number' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
