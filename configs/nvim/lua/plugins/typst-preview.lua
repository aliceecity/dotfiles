require 'typst-preview'.setup {
  dependencies_bin = {
    tinymist = "tinymist",
  },

  open_cmd = 'firefox --new-window "%s" 2>/dev/null',
}
