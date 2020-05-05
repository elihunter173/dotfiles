-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")

local config = require("config")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
      preset = naughty.config.apps.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
        preset = naughty.config.apps.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err),
      })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "/theme.lua")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

for _, cmd in ipairs(config.autostart) do
  awful.spawn(cmd, false)
end

-- Menubar configuration
menubar.utils.terminal = config.apps.terminal -- Set the terminal for applications that require it
-- }}}

MediaPlayer = require("media_player")
spotify = MediaPlayer:new("spotify")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
  )

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true}
        )
    end
  end),
  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({ }, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function()
    awful.client.focus.byidx(-1)
  end)
  )

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local VOLUME_GET_CMD = "amixer sget Master"
local VOLUME_INC_CMD = "amixer sset Master 5%+"
local VOLUME_DEC_CMD = "amixer sset Master 5%-"
local VOLUME_TOG_CMD = "amixer sset Master toggle"

local function reset_tagnames(tags)
  for i, t in ipairs(tags) do
    t.name = i
  end
end
-- Create a launcher widget and a main menu
mylauncher = awful.widget.launcher{
  image = beautiful.awesome_icon,
  menu = awful.menu{
    items = {
      {
        "awesome",
        {
          { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
          { "manual", config.apps.terminal .. " -e man awesome" },
          { "edit config", config.apps.editor .. " " .. awesome.conffile },
          { "restart", awesome.restart },
          { "quit", function() awesome.quit() end },
        },
        beautiful.awesome_icon,
      },
      { "open terminal", config.apps.terminal },
    },
  },
}

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  -- local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
  -- Start at default layout
  awful.tag({"1"}, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
      awful.button({ }, 1, function() awful.layout.inc( 1) end),
      awful.button({ }, 3, function() awful.layout.inc(-1) end),
      awful.button({ }, 4, function() awful.layout.inc( 1) end),
      awful.button({ }, 5, function() awful.layout.inc(-1) end)
    ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist{
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup{
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      pulse,
      -- volumebar_widget({
      --     mute_color = beautiful.bg_urgent,
      --     shape = "rounded_bar",
      --     margins = 8,
      --     get_volume_cmd = VOLUME_GET_CMD,
      --     inc_volume_cmd = VOLUME_INC_CMD,
      --     dec_volume_cmd = VOLUME_DEC_CMD,
      --     tog_volume_cmd = VOLUME_TOG_CMD,
      --   }),
      wibox.widget.systray(),
      wibox.widget.textclock(),
      s.mylayoutbox,
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function() mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
  ))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
  awful.key(
    {modkey}, "F1",
    hotkeys_popup.show_help,
    {description="show help", group="awesome"}),
  awful.key(
    {modkey}, "Escape",
    awful.tag.history.restore,
    {description = "go back", group = "tag"}),
  awful.key({ modkey,           }, "j",
    function() awful.client.focus.byidx(-1) end,
    {description = "focus previous by index", group = "client"}),
  awful.key(
    {modkey}, "k",
    function() awful.client.focus.byidx(1) end,
    {description = "focus next by index", group = "client"}),

  -- Layout manipulation
  awful.key(
    {modkey, "Shift"}, "j",
    function() awful.client.swap.byidx(-1) end,
    {description = "swap with next client by index", group = "client"}),
  awful.key(
    {modkey, "Shift"}, "k",
    function() awful.client.swap.byidx(1) end,
    {description = "swap with previous client by index", group = "client"}),
  awful.key(
    {modkey, "Control"}, "j",
    function() awful.screen.focus_relative(-1) end,
    {description = "focus the next screen", group = "screen"}),
  awful.key(
    {modkey, "Control"}, "k",
    function() awful.screen.focus_relative(1) end,
    {description = "focus the previous screen", group = "screen"}),
  awful.key(
    {modkey}, "u",
    awful.client.urgent.jumpto,
    {description = "jump to urgent client", group = "client"}),
  awful.key(
    {modkey}, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "client"}),

  awful.key(
    {modkey}, "n",
    function()
      naughty.notify({
          title = "Test",
          text = "This is a test",
        })
    end),

  -- Tag control
  awful.key(
    {modkey, "Control"}, "t",
    function()
      local screen = awful.screen.focused()
      local tag = awful.tag.add(
        #screen.tags + 1,
        {
          screen = awful.screen.focused(),
          layout = awful.layout.layouts[1],
        })
      reset_tagnames(screen.tags)
      tag:view_only()
    end,
    {description = "add new tag", group = "tag"}),
  awful.key(
    {modkey, "Control"}, "w",
    function()
      local screen = awful.screen.focused()
      local tag = screen.selected_tag
      if not tag then return end
      tag:delete()
      reset_tagnames(screen.tags)
    end,
    {description = "remove tag", group = "tag"}),
  awful.key(
    {modkey}, "h",
    awful.tag.viewprev,
    {description = "view previous", group = "tag"}),
  awful.key(
    {modkey, "Shift"}, "h",
    function()
      local screen = awful.screen.focused()
      local cur = screen.selected_tag
      local nxt = screen.tags[cur.index - 1]
      if not nxt then return end
      client.focus:move_to_tag(nxt)
      nxt:view_only()
    end,
    {description = "move client to next", group = "tag"}),
  awful.key(
    {modkey}, "l",
    awful.tag.viewnext,
    {description = "view next", group = "tag"}),
  awful.key(
    {modkey, "Shift"}, "l",
    function()
      local screen = awful.screen.focused()
      local cur = screen.selected_tag
      local nxt = screen.tags[cur.index + 1]
      if not nxt then return end
      client.focus:move_to_tag(nxt)
      nxt:view_only()
    end,
    {description = "move client to next", group = "tag"}),


  -- App Launcher
  awful.key(
    {modkey}, "Return",
    function() awful.spawn(config.apps.launcher) end,
    {description = "launch apps", group = "launcher"}),
  awful.key(
    {modkey, "Shift"}, "Return",
    function() awful.spawn(config.apps.runner) end,
    {description = "run command", group = "launcher"}),
  awful.key(
    {modkey, "Ctrl"}, "Return",
    function() awful.spawn(config.apps.window_finder) end,
    {description = "search for window", group = "launcher"}),
  awful.key(
    {modkey}, "t",
    function() awful.spawn(config.apps.terminal) end,
    {description = "open a terminal", group = "launcher"}),
  awful.key(
    {modkey}, "b",
    function() awful.spawn("firefox") end,
    {description = "open a web browser", group = "launcher"}),

  -- Media control
  awful.key(
    {}, "XF86AudioRaiseVolume",
    function() awful.spawn(VOLUME_INC_CMD, false) end,
    {description = "increase volume", group = "media"}),
  awful.key(
    {}, "XF86AudioLowerVolume",
    function() awful.spawn(VOLUME_DEC_CMD, false) end,
    {description = "decrease volume", group = "media"}),
  awful.key(
    {}, "XF86AudioMute",
    function() awful.spawn(VOLUME_TOG_CMD, false) end,
    {description = "(un)mute", group = "media"}),
  awful.key(
    {}, "XF86AudioPlay",
    function() if spotify.is_connected then spotify:PlayPause() end end,
    {description = "play/pause current media", group = "media"}),
  awful.key(
    {}, "XF86AudioNext",
    function() if spotify.is_connected then spotify:Next() end end,
    {description = "play next song", group = "media"}),
  awful.key(
    {}, "XF86AudioPrev",
    function() if spotify.is_connected then spotify:Previous() end end,
    {description = "play previous song", group = "media"}),

  -- Awesome control
  awful.key(
    {modkey, "Control"}, "r",
    awesome.restart,
    {description = "reload awesome", group = "awesome"}),
  awful.key(
    {modkey, "Shift"}, "q",
    awesome.quit,
    {description = "quit awesome", group = "awesome"}),

  awful.key(
    {modkey}, "l",
    function() awful.tag.incmwfact(0.05) end,
    {description = "increase master width factor", group = "layout"}),
  awful.key(
    {modkey}, "h",
    function() awful.tag.incmwfact(-0.05) end,
    {description = "decrease master width factor", group = "layout"}),
  awful.key(
    {modkey, "Shift"}, "h",
    function() awful.tag.incnmaster(1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key(
    {modkey, "Shift"}, "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key(
    {modkey, "Control"}, "h",
    function() awful.tag.incncol(1, nil, true) end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key(
    {modkey, "Control"}, "l",
    function() awful.tag.incncol(-1, nil, true) end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key(
    {modkey}, "space",
    function() awful.layout.inc(1) end,
    {description = "select next", group = "layout"}),
  awful.key(
    {modkey, "Shift"}, "space",
    function() awful.layout.inc(-1) end,
    {description = "select previous", group = "layout"}),

  awful.key(
    {modkey, "Control"}, "n",
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", {raise = true}
          )
      end
    end,
    {description = "restore minimized", group = "client"})
  )

clientkeys = gears.table.join(
  awful.key(
    {modkey}, "z",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
  awful.key(
    {modkey}, "q",
    function (c) c:kill() end,
    {description = "close", group = "client"}),
  awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),
  awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    {description = "toggle keep on top", group = "client"})
  )

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
  )

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    }
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = {
      type = { "normal", "dialog" }
    },
    properties = {
      titlebars_enabled = true
    },
  },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
    )

  awful.titlebar(c) : setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
