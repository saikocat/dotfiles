-- Bazel: lazy load on first use to avoid provider warnings at startup.

local bazel_src = 'https://github.com/alexander-born/bazel.nvim'
local bazel = nil

local function load_bazel()
  if bazel ~= nil then
    return bazel
  end

  vim.pack.add({ bazel_src }, { load = false })
  vim.g.bazel_cmd = 'bazelisk'
  bazel = require 'bazel'
  return bazel
end

local function with_bazel_vim(callback)
  if vim.fn.has 'python3' == 0 then
    vim.notify('bazel.nvim jump helpers require Neovim python3 provider support.', vim.log.levels.WARN)
    return
  end

  load_bazel()
  vim.cmd.packadd 'bazel.nvim'
  callback()
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'bzl',
  once = true,
  callback = function()
    if vim.fn.has 'python3' == 0 then
      return
    end

    vim.keymap.set('n', 'gd', function()
      with_bazel_vim(vim.fn.GoToBazelDefinition)
    end, { buffer = true, desc = 'Goto Definition' })
  end,
})

vim.keymap.set('n', 'gbt', function()
  with_bazel_vim(vim.fn.GoToBazelTarget)
end, { desc = 'Goto Bazel Build File' })

vim.keymap.set('n', '<Leader>bl', function()
  load_bazel().run_last()
end, { desc = 'Bazel Last' })

vim.keymap.set('n', '<Leader>bt', function()
  load_bazel().run_here('test', vim.g.bazel_config)
end, { desc = 'Bazel Test' })

vim.keymap.set('n', '<Leader>bb', function()
  load_bazel().run_here('build', vim.g.bazel_config)
end, { desc = 'Bazel Build' })

vim.keymap.set('n', '<Leader>br', function()
  load_bazel().run_here('run', vim.g.bazel_config)
end, { desc = 'Bazel Run' })

vim.keymap.set('n', '<Leader>bdb', function()
  load_bazel().run_here('build', vim.g.bazel_config .. ' --compilation_mode dbg --copt=-O0')
end, { desc = 'Bazel Debug Build' })
