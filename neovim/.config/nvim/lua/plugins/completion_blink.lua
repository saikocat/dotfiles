return {
  { -- Autocompletion
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',

      -- Faster LuaLS setup
      'folke/lazydev.nvim',
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo +nightly build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-e: Hide menu
      -- C-k: Toggle signature help
      --
      -- See the full "keymap" documentation for information on defining your own keymap.
      --
      keymap = { preset = 'default' },
      -- keymap = {
      --    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      --    ['<C-e>'] = { 'hide' },
      --    ['<C-y>'] = { 'select_and_accept' },

      --    ['<C-p>'] = { 'select_prev', 'fallback' },
      --    ['<C-n>'] = { 'select_next', 'fallback' },

      --    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      --    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      --    ['<Tab>'] = { 'snippet_forward', 'fallback' },
      --    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      --  },
      appearance = {
        -- highlight_ns = vim.api.nvim_create_namespace 'blink_cmp',
        -- kind_icons = {},
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },

    opts_extend = { 'sources.default' },
  },
}
