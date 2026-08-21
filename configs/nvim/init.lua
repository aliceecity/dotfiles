require("config.options")
require("config.keymaps")
require("config.autocmd")

require("plugins")

require("plugins.comment")
require("plugins.mini-move")
require("plugins.mini-surround")
require("plugins.oil")
require("plugins.treesitter")

require("config.snippet")

-- Transparent background
vim.cmd [[
  highlight Normal      guibg=none
  highlight NonText     guibg=none
  highlight NormalNC    guibg=none
  highlight EndOfBuffer guibg=none
  highlight SignColumn  guibg=none
]]
