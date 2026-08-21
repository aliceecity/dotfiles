require('oil').setup({
  keymaps = {
    ['<CR>'] = 'actions.select',
    ['<C-p>'] = 'actions.preview',
    ['gx'] = 'actions.open_external',
    ['g.'] = {
      'actions.toggle_hidden',
      mode = 'n',
    },
  },

  use_default_keymaps = false,
})
