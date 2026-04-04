-- Diffview: Git diff viewer

local diffview_src = 'https://github.com/sindrets/diffview.nvim'

local function load_diffview()
  vim.pack.add({ diffview_src })
end

vim.api.nvim_create_user_command('OpenDiff', function(opts)
  load_diffview()
  vim.cmd('DiffviewOpen ' .. opts.args .. '^..' .. opts.args)
end, { nargs = 1 })

vim.keymap.set('n', '<leader>gs', function()
  load_diffview()
  vim.cmd.DiffviewOpen()
end, { desc = 'Git status' })

vim.keymap.set('n', '<leader>gf', function()
  load_diffview()
  vim.cmd('DiffviewFileHistory %')
end, { desc = 'Git file history' })

vim.keymap.set('n', '<leader>gl', function()
  load_diffview()
  vim.cmd.DiffviewFileHistory()
end, { desc = 'Git log history' })

vim.keymap.set('n', '<leader>gt', function()
  load_diffview()
  vim.cmd('DiffviewFileHistory -g --range=stash')
end, { desc = 'Git latest stash' })
