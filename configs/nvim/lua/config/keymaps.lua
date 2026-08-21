vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '-', '<cmd>:Oil <CR>', { desc = 'Go back to oil' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>w', '<cmd>:w <CR>', { desc = 'write' })
vim.keymap.set('n', '<leader>q', '<cmd>:q <CR>', { desc = 'quit' })
vim.keymap.set({'v', 'x' }, '<leader>n', ':norm ', { desc = 'norm' })
vim.keymap.set('n', '<leader>n', ':%norm ', { desc = '%norm' })
vim.keymap.set({'v', 'x'}, "<leader>s", function()
  vim.cmd('normal! "zy')
  local selection = vim.fn.escape(vim.fn.getreg("z"), [[\/.*$^~[]])

  local cmd = ":%s/" .. selection .. "//g"

  vim.fn.feedkeys(cmd, "n")

  -- move cursor left twice so you're between the slashes
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true),
    "n",
    false
  )
end, { desc = "Substitute selected text globally" })
vim.keymap.set('n', "<leader>s", function()
  vim.cmd('normal! "zy')
  local cmd = ":%s///g"

  vim.fn.feedkeys(cmd, "n")

  -- move cursor so you're between the slashes
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Left><Left><Left>", true, false, true),
    "n",
    false
  )
end, { desc = "%s///g" })
