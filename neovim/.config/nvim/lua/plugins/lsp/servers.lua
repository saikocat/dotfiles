-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
return {
  bashls = {},
  bzl = {
    filetypes = { 'bzl', 'bazel' },
  },
  clangd = {},
  dockerls = {},
  gopls = {
    directoryFilters = {
      '-.git',
      '-.idea',
      '-.vscode',
      '-.vscode-test',
      '-**/vendor',
      '-**/bazel-bin',
      '-**/bazel-out',
      '-**/bazel-testlogs',
      '-**/node_modules',
    },
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
    gofumpt = true,
    usePlaceholders = true,
  },
  jsonls = {},
  marksman = {},
  pyright = {},
  rust_analyzer = {},
  sqlls = {},
  yamlls = {},
  -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`tsserver`) will work just fine
  -- tsserver = {},
  --

  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
        diagnostics = { globals = { 'vim' } },
      },
    },
  },
}
