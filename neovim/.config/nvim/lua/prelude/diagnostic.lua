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
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}
