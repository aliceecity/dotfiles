vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '-', '<cmd>:Oil <CR>', { desc = 'Go back to oil' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>m', '<cmd>:RenderMarkdown set <CR>', { desc = 'toggle markdown rendering' })

vim.keymap.set('n', '<leader>t', '<cmd>:TypstPreview<CR>', { desc = 'launch typst-preview' })

vim.keymap.set('n', '<leader>zc', '1z=', { desc = 'correct with first suggestion' })
vim.keymap.set('n', '<leader>ze', '<cmd>:set spell spelllang=en_us<CR>', { desc = 'english spellcheck on' })
vim.keymap.set('n', '<leader>zs', '<cmd>:set spell spelllang=es<CR>', { desc = 'spanish spellcheck on' })
vim.keymap.set('n', '<leader>zo', '<cmd>:set nospell<CR>', { desc = 'spanish spellcheck on' })
vim.keymap.set('n', '<leader>a', function()
  local accents = {
    ["a"] = "á", ["á"] = "a",
    ["e"] = "é", ["é"] = "e",
    ["i"] = "í", ["í"] = "i",
    ["o"] = "ó", ["ó"] = "o",
    ["u"] = "ú", ["ú"] = "u",
    ["A"] = "Á", ["Á"] = "A",
    ["E"] = "É", ["É"] = "E",
    ["I"] = "Í", ["Í"] = "I",
    ["O"] = "Ó", ["Ó"] = "O",
    ["U"] = "Ú", ["Ú"] = "U",
  }

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local char = vim.fn.strcharpart(line:sub(col + 1), 0, 1)

  local replacement = accents[char]
  if not replacement then
    return
  end

  local start_col = col
  local end_col = col + #char

  vim.api.nvim_buf_set_text(
    0,
    row - 1, start_col,
    row - 1, end_col,
    { replacement }
  )

  vim.api.nvim_win_set_cursor(0, { row, start_col })
end, { desc = 'add or remove tilde' })

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
