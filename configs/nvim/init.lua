-- Opts
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.showmode = false
vim.o.signcolumn = 'yes'

vim.o.undofile = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = {tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.swapfile = false

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.inccommand = 'split'

vim.o.cursorline = false
vim.o.scrolloff = 10

vim.o.confirm = true

-- Binds
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '-', '<cmd>:Oil <CR>', { desc = 'Go back to oil' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>w', '<cmd>:w <CR>', { desc = 'write' })
vim.keymap.set('n', '<leader>q', '<cmd>:q <CR>', { desc = 'quit' })

-- Set up Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({

	spec = 'plugins',

  'NMAC427/guess-indent.nvim',

})

-- LuaSnip

local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

local ps = ls.parser.parse_snippet

ls.add_snippets(
  "java", {
    ps(
      "pc",
      "public class $1 {\n  public static void main(String[] args) {\n    $2\n  }\n}"
    ),
    ps(
      "main",
      "public static void main(String[] args) {\n\t$1\n}"
    ),
    ps(
      "sout",
      "System.out.println(\"$1\");"
    ),
    ps(
      "tc",
      "try {\n  $1\n} catch ($2 e){\n  $3\n}"
    ),
  }
)

ls.add_snippets(
  "c", {
    ps(
      "main",
      "int main(int argc, char** argv) {\n  $1\n}"
    ),
    ps(
      "sw",
      "switch($1){\n  case $2:\n    $3\n    break;\n}"
    ),
  }
)

ls.add_snippets(
  "rust", {
    ps(
      "mt",
      "match $1 {\n  $2 => $3,\n  _ => {}\n}"
    ),
    ps(
      "drv",
      "#[derive($1)]"
    ),
    ps(
      "disp",
      "impl Display for $1 {\n  fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), Error> {\n    $2\n  }\n}"
    ),
    ps(
      "std",
      "use std::{\n  $1,\n};"
    ),
  }
)

-- Stuff
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight NormalNC guibg=none
  highlight EndOfBuffer guibg=none
  highlight SignColumn guibg=none
]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
