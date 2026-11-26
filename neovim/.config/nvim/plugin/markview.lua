-- Markview: internally lazy-loaded.
vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }

require('markview').setup {
  preview = {
    -- Reduce text jumping when moving the cursor (default: 150ms).
    -- Debounce	| Responsiveness	| Rendering overhead
    -- or 16 | for roughly one frame at 60Hz (1000/60) | high overhead
    -- 30 | very responsive | high overhead
    -- 50 | responsive | balanced
    debounce = 50,
  },
  -- Remove additional padding so rendered text aligns with plaintext.
  markdown = {
    code_blocks = {
      pad_amount = 0,
    },
    list_items = {
      marker_minus = { add_padding = false },
      marker_plus = { add_padding = false },
      marker_star = { add_padding = false },
      marker_dot = { add_padding = false },
      marker_parenthesis = { add_padding = false },
    },
  },
}
