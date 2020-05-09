-- Collection of configuration data used throughout my awesome setup

local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.spiral.dwindle,
}

-- TODO: Should I handle autostart functionality here? I'd rather not
return {
  apps = {
    terminal = "alacritty",
    launcher = "rofi -show drun",
    runner = "rofi -show run",
    window_finder = "rofi -show window",
    lock = "i3lock",
    screenshot = "flameshot gui",
    filebrowser = "thunar",
    browser = "firefox",
    editor = "alacritty -e nvim",
    music_player = "spotify",
  },
  autostart = {
    -- Ensure we have the proper monitor setup on startup
    "autorandr --change",
  },
}
