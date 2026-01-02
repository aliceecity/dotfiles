return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',

  opts = {
    ensure_installed = { 'html', 'css', 'rust', 'bash', 'c', 'lua', 'typst'},
    auto_install = false,
    highlight = {
      enable = true,
    },
  },
}
