require("alice.options")
require("alice.keymaps")
require("alice.lazy-init")

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight NormalNC guibg=none
  highlight EndOfBuffer guibg=none
]]

function poorTypstPreview()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file name")
    return
  end

  local script = "/home/sancho/scripts/typst-preview.sh"

  vim.fn.jobstart({ "bash", script, file }, {
    detach = true,
  })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
