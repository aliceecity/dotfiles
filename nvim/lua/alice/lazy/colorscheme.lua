return {
  "vague-theme/vague.nvim",
  lazy = false,
  transparent = true,
  priority = 1000,
  config = function()
    require("vague").setup({
			italic = false
    })
    vim.cmd("colorscheme vague")
  end
}
