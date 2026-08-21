local languages = {
  'java',
  'html',
  'css',
  'rust',
  'bash',
  'c',
  'lua',
  'typst',
}

require('nvim-treesitter').setup()

require('nvim-treesitter').install(languages)

vim.treesitter.language.register('bash', 'sh')

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'java',
    'html',
    'css',
    'rust',
    'sh',
    'c',
    'lua',
    'typst',
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
