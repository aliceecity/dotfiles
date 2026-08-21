vim.pack.add({
  { src = "https://github.com/vague-theme/vague.nvim" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/nvim-mini/mini.move" },
  { src = "https://github.com/echasnovski/mini.surround" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/NMAC427/guess-indent.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-lualine/lualine.nvim"}
})

require("vague").setup({
  italic = false,
})

vim.cmd.colorscheme("vague")
