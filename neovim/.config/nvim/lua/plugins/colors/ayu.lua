return {
  {
    'Shatur/neovim-ayu',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme('ayu-mirage')
    end,
  }
}
