local waywall = require("waywall")
local helpers = require("waywall.helpers")

local mcsr_dir = os.getenv("HOME") .. "/mcsr/"

local thin = "*-masculine"
local tall_pre_ctrl = "Ctrl-caps_lock"
local tall_pre_alt = "Alt-caps_lock"
local tall_pre = "caps_lock"
local tall = "*-N"
local wide = "*-MB4"

local normal_sens = 4.41277313
local tall_sens = 0.29768304

local overlay_png = mcsr_dir .. "overlay.png"
local bg_path = mcsr_dir .. "epic_bg.png"
local crosshair_path = mcsr_dir .. "oneshot.png"

local crosshair_image = nil
local crosshair_active = nil

local config = {
  input = {
    layout = "es",
    variant = "nodeadkeys",
    remaps = {
      ["F1"] = "0",
      ["MB5"] = "backspace"
    },

    sensitivity = normal_sens,

    confine_pointer = true,
  },

  theme = {
    background_png = bg_path,

    ninb_anchor = {
      position = "right",
      y = -270
    }
  },
}

-- 1883,859 27x26
helpers.res_mirror({ src = { x = 1884, y = 860, w = 26, h = 23 }, dst = { x = 1476, y = 696, w = 104, h = 92 }, depth = 2, color_key = { input = "#4DE1CA", output = "#4DE1CAFF" } }, 0, 0) -- spawner total %
helpers.res_mirror({ src = { x = 1884, y = 860, w = 26, h = 23 }, dst = { x = 1480, y = 700, w = 104, h = 92 }, depth = 1, color_key = { input = "#4DE1CA", output = "#133832FF" } }, 0, 0) -- spawner total % (shadow)

helpers.res_mirror({ src = { x = 1828, y = 860, w = 31, h = 23 }, dst = { x = 1452, y = 660, w = 124, h = 92 }, depth = 2, color_key = { input = "#4DE1CA", output = "#4DE1CAFF" } }, 0, 0) -- spawner %
helpers.res_mirror({ src = { x = 1828, y = 860, w = 31, h = 23 }, dst = { x = 1456, y = 664, w = 124, h = 92 }, depth = 1, color_key = { input = "#4DE1CA", output = "#133832FF" } }, 0, 0) -- spawner % (shadow)

helpers.res_mirror({ src = { x = 252, y = 519, w = 15, h = 21 }, dst = { x = 945, y = 920, w = 30, h = 42 }, depth = 3, color_key = { input = "#DDDDDD", output = "#FF00FFFF" } }, 0, 0) -- difficulty

helpers.res_mirror({ src = { x = 145, y = 7900, w = 30, h = 580 }, dst = { x = 0, y = 315, w = 800, h = 450 } }, 320, 16380) -- eye measuring cropout, 15 pixels each side, 145->130 and 30->60 for 30 on each side

helpers.res_mirror({ src = { x = 0, y = 15980, w = 320, h = 180 }, dst = { x = 1120, y = 610, w = 216, h = 122 } }, 320, 16380) -- tall pie
helpers.res_mirror({ src = { x = 0, y = 680, w = 320, h = 180 }, dst = { x = 1120, y = 610, w = 216, h = 122 } }, 320, 1080) -- thin tiny pie
helpers.res_mirror({ src = { x = 12, y = 37, w = 37, h = 9 }, dst = { x = 1120, y = 374, w = 216, h = 52 } }, 320, 16380) -- tall ecount
helpers.res_mirror({ src = { x = 13, y = 37, w = 37, h = 9 }, dst = { x = 1120, y = 374, w = 216, h = 52 } }, 320, 1080) -- thin ecount
helpers.res_mirror({ src = { x = 1, y = 28, w = 31, h = 9 }, dst = { x = 1120, y = 732, w = 216, h = 63 } }, 320, 16380) -- tall c counter
helpers.res_mirror({ src = { x = 1, y = 28, w = 31, h = 9 }, dst = { x = 1120, y = 732, w = 216, h = 63 } }, 320, 1080) -- thin c counter

helpers.res_mirror({ src = { x = 228, y = 860, w = 26, h = 23 }, dst = { x = 1120, y = 426, w = 216, h = 184 } }, 320, 1080) -- thin numbers

helpers.res_mirror({ src = { x = 228, y = 16160, w = 26, h = 23 }, dst = { x = 1120, y = 426, w = 216, h = 184 } }, 320, 16380) -- tall

helpers.res_image(overlay_png, { dst = { x = 0, y = 315, w = 800, h = 450 } }, 320, 16380) -- overlay image

local resolutions = {
  thin = helpers.toggle_res(320, 1080, 0),
  tall = helpers.toggle_res(320, 16380, tall_sens), --0.04 is the eyezoom sens, 16380 shouldnt change anything with ninbot.
  wide = helpers.toggle_res(1920, 270),
  tall_pre = helpers.toggle_res(320, 16380, 0),
  -- oneshot = helpers.toggle_res(1920, 1080, 0.0000000001), --sens set to really low since looking around kills velocity
}

config.actions = {
  [thin] = resolutions.thin,
  [tall] = resolutions.tall,
  [tall_pre] = resolutions.tall_pre,
  [tall_pre_ctrl] = resolutions.tall_pre,
  [tall_pre_alt] = resolutions.tall_pre,
  [wide] = resolutions.wide,

  ["*-Ctrl-N"] = function() waywall.exec("ninjabrain-bot") end,
  ["*-6"] = helpers.toggle_floating,

  ["*-C"] = function()
    if waywall.get_key("F3") then waywall.show_floating(true) end
    return false
  end,

  ["*-Y"] = function()
    if crosshair_image then
      crosshair_image:close(); crosshair_image = nil
    end
    if crosshair_active then
      crosshair_active = false
    else
      crosshair_active = true
      crosshair_image = waywall.image(crosshair_path, {
        dst = {
          x = 910, y = 490,
          w = 100, h = 100,
        }
      })
    end
  end,
}

return config
