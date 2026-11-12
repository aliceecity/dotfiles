hl.window_rule({match = {class = ".*vesktop.*"}, workspace = "3 silent"})
hl.window_rule({match = {class = ".*steam.*"}, workspace = "4 silent"})
hl.window_rule({match = {title = "waywall"}, workspace = "4 silent", idle_inhibit = "always"})
hl.window_rule({match = {class = ".*prism.*"}, workspace = "4 silent"})
hl.window_rule({match = {class = "krita"}, workspace = "4 silent"})

hl.window_rule({
  match = {title = "Volume Control"},
  float = true,
  size = {800, 600}}
)

hl.window_rule({
  match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },
  float = true,
  pin   = true,
  size  = "480 270",
})
