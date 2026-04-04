vim.loader.enable()

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'prelude'

-- PackChanged hooks for plugins with build steps.
-- Must be registered BEFORE the first vim.pack.add() call.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    local changed = kind == 'install' or kind == 'update'

    if name == 'telescope-fzf-native.nvim' and changed then
      if vim.fn.executable 'make' == 0 then
        vim.schedule(function()
          vim.notify('telescope-fzf-native.nvim requires `make` to build the fzf extension.', vim.log.levels.WARN)
        end)
        return
      end

      local result = vim.system({ 'make' }, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then
        vim.schedule(function()
          vim.notify(
            table.concat({
              'Failed to build telescope-fzf-native.nvim.',
              result.stderr or '',
            }, '\n'),
            vim.log.levels.ERROR
          )
        end)
      end
      return
    end

    if name == 'nvim-treesitter' and changed then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- Load all eager packages
vim.pack.add(require 'config.pack_specs')

-- Colorscheme immediately after loading
vim.cmd.colorscheme 'ayu-mirage'

-- Built-in packages (require Neovim >= 0.12)
vim.cmd.packadd 'nvim.undotree'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
