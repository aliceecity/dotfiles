require("keybinds")({
  terminal = "alacritty",
  main_monitor = "eDP-1"
})

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

local terminal = "alacritty"

hl.on("hyprland.start", function () 
  hl.exec_cmd(terminal)
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaybg -i ~/dotfiles/wallpaper.jpg -m fill")
end)

hl.config({
  general = {
    gaps_out = 10,
    gaps_in = 5,
    col = {active_border = "rgb(5c47c9)"},
    border_size = 2,
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

-- Laptop Specific Binds
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {repeating = true})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {repeating = true})
hl.bind(" XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), {repeating = true})
hl.bind(" XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {repeating = true})
hl.bind(" XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
