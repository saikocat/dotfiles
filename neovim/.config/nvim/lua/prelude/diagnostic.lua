-- Diagnostic Config
-- See :help vim.diagnostic.Opts

-- Ensure diagnostic sign types exist and have Nerd Font glyphs
local sign_text = vim.g.have_nerd_font
    and {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    }
  or nil

-- Keep your diagnostic config (signs can be omitted now)
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    priority = 9999,
    text = sign_text,
  },
  virtual_text = function(_, bufnr)
    if vim.b[bufnr].diagnostic_virtual_text == false then
      return false
    end

    return {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        return diagnostic.message
      end,
    }
  end,
}

local keymap = vim.keymap

-- diagnostics
-- <Cmd>lua vim.diagnostic.goto_next()<CR>
keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { desc = 'Go to [N]ext diagnostic' })
keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious diagnostic' })
keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap.set('n', '<leader>dt', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr].diagnostic_virtual_text = vim.b[bufnr].diagnostic_virtual_text == false

  vim.diagnostic.hide(nil, bufnr)
  vim.diagnostic.show(nil, bufnr)
end, { desc = '[T]oggle Diagnostic Virtual Text (Buffer)' })
