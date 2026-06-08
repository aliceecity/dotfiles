return function (args)
  local terminal = args.terminal
  local main_monitor = args.main_monitor

  hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
  hl.bind("SUPER + C", hl.dsp.exec_raw("firefox"))
  hl.bind("SUPER + R", hl.dsp.exec_raw("hyprctl reload"))

  hl.bind("SUPER + X", hl.dsp.window.close())
  hl.bind("SUPER + SHIFT + X", hl.dsp.window.kill())

  hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
  hl.bind("SUPER + ALT + mouse:272", hl.dsp.window.resize())

  hl.bind("SUPER + ALT + H", hl.dsp.window.resize({x = -60, y = 0}))
  hl.bind("SUPER + ALT + J", hl.dsp.window.resize({x = 0, y = 60}))
  hl.bind("SUPER + ALT + K", hl.dsp.window.resize({x = 0, y = -60}))
  hl.bind("SUPER + ALT + L", hl.dsp.window.resize({x = 60, y = -60}))

  hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({direction="l"}))
  hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({direction="d"}))
  hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({direction="u"}))
  hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({direction="r"}))

  hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grim -g  \"$(slurp)\" - | wl-copy"))

  hl.bind("SUPER + H", hl.dsp.focus({direction = "l"}))
  hl.bind("SUPER + J", hl.dsp.focus({direction = "d"}))
  hl.bind("SUPER + K", hl.dsp.focus({direction = "u"}))
  hl.bind("SUPER + l", hl.dsp.focus({direction = "r"}))

  hl.bind("SUPER + T", hl.dsp.window.float())
  hl.bind("SUPER + F", hl.dsp.window.fullscreen())

  hl.bind("SUPER + Tab", hl.dsp.window.cycle_next())

  hl.bind("SUPER + C", hl.dsp.exec_cmd("rofi -show drun -theme ~/dotfiles/configs/rofi/colors.rasi"))

  for i=1,9 do
    hl.bind("SUPER + " .. i, function() 
      hl.dispatch(hl.dsp.focus({monitor = main_monitor}))
      hl.dispatch(hl.dsp.focus({workspace = i}))
    end)
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({workspace = i, follow = false}))
  end
end
