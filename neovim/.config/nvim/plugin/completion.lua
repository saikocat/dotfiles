-- Blink.cmp: Autocompletion

-- Faster LuaLS setup
require('lazydev').setup()

require('blink.cmp').setup {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-e: Hide menu
  -- C-k: Toggle signature help
  keymap = {
    preset = 'default',
  },
  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    use_nvim_cmp_as_default = true,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'lazydev' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
  fuzzy = { implementation = 'prefer_rust_with_warning' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
