require("keybinds")({
  terminal = "alacritty",
  main_monitor = "HDMI-A-1"
})

-- Main monitor
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@144",
  position = "0x0",
  scale = 1,
})

-- Second monitor
hl.monitor({
  output = "DP-1",
  mode = "preferred",
  position = "-1366x250",
  scale = 1,
})

hl.workspace_rule({workspace = "r[1-9]", monitor = "HDMI-A-1"})
hl.workspace_rule({workspace = "name:S", monitor = "DP-1"})

local terminal = "alacritty"

hl.on("hyprland.start", function () 
  hl.exec_cmd(terminal)
  hl.exec_cmd("waybar")
  hl.exec_cmd("firefox")
  hl.exec_cmd("swaybg -i ~/dotfiles/wallpaper.jpg -m fill")
end)

hl.config({
  general = {
    gaps_out = 10,
    gaps_in = 5,
    col = {active_border = "rgb(7d7c78)"},
    border_size = 3,
  },

  debug = {
    disable_logs = false,
  },

  input = {
    kb_layout = "es",
    kb_variant = ",nodeadkeys",
    numlock_by_default = true,
    repeat_rate = 50,
    repeat_delay = 200,
  },

  animations = {
    enabled = false,
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  }
})

-- Laptop Equivalent Specific Binds
hl.bind("SUPER + PLUS", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), {repeating = true})
hl.bind("SUPER + MINUS", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {repeating = true})

hl.bind("SUPER + MASCULINE", hl.dsp.focus({workspace = "name:S"}))
hl.bind("SUPER + SHIFT + MASCULINE", hl.dsp.window.move({workspace = "name:S", follow = false}))
