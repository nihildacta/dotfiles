-- Standard awesome library
local awesome = awesome -- luacheck: ignore
local root = root -- luacheck: ignore
local screen = screen -- luacheck: ignore
local client = client -- luacheck: ignore

require("awful.autofocus")
require("awful.hotkeys_popup.keys.vim")
require("nihil.exception.handler")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local wallpaper = require("nihil.theme.wallpaper")

beautiful.init("~/dotfiles/awesomevm/themes/bladerunner/theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = "qterminal"

-- Default modkey.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile, awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom, awful.layout.suit.tile.top,
    awful.layout.suit.fair, awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral, awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max, awful.layout.suit.max.fullscreen,
    awful.layout.suit.corner.nw, awful.layout.suit.floating
}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({theme = {width = 250}})
        end
    end
end
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal
-- }}}

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end), awful.button({}, 3, client_menu_toggle_fn()), awful.button({}, 4,
                                                                     function()
        awful.client.focus.byidx(1)
    end), awful.button({}, 5, function() awful.client.focus.byidx(-1) end))

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", wallpaper.set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    wallpaper.set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag({"d", "w", "m", "x"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will
    -- contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                              awful.button({}, 1,
                                           function() awful.layout.inc(1) end),
                              awful.button({}, 3,
                                           function()
            awful.layout.inc(-1)
        end), awful.button({}, 4, function() awful.layout.inc(1) end),
                              awful.button({}, 5,
                                           function()
            awful.layout.inc(-1)
        end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all,
                                       taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter
                                             .currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({position = "bottom", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox
        }
    }
end)
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(awful.key({modkey}, "s",
                                              hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome"
}), awful.key({modkey}, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
                                    awful.key({modkey}, "Right",
                                              awful.tag.viewnext, {
    description = "view next",
    group = "tag"
}), awful.key({modkey}, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

                                    awful.key({modkey}, "j", function()
    awful.client.focus.byidx(1)
end, {description = "focus next by index", group = "client"}),
                                    awful.key({modkey}, "k", function()
    awful.client.focus.byidx(-1)
end, {description = "focus previous by index", group = "client"}),

-- Layout manipulation
                                    awful.key({modkey, "Shift"}, "j",
                                              function()
    awful.client.swap.byidx(1)
end, {description = "swap with next client by index", group = "client"}),
                                    awful.key({modkey, "Shift"}, "k",
                                              function()
    awful.client.swap.byidx(-1)
end, {description = "swap with previous client by index", group = "client"}),
                                    awful.key({modkey, "Control"}, "j",
                                              function()
    awful.screen.focus_relative(1)
end, {description = "focus the next screen", group = "screen"}),
                                    awful.key({modkey, "Control"}, "k",
                                              function()
    awful.screen.focus_relative(-1)
end, {description = "focus the previous screen", group = "screen"}),
                                    awful.key({modkey}, "u",
                                              awful.client.urgent.jumpto, {
    description = "jump to urgent client",
    group = "client"
}), awful.key({modkey}, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then client.focus:raise() end
end, {description = "go back", group = "client"}), -- Standard program
awful.key({modkey}, "Return", function() awful.spawn(terminal) end,
          {description = "open a terminal", group = "launcher"}),
                                    awful.key({modkey, "Control"}, "r",
                                              awesome.restart, {
    description = "reload awesome",
    group = "awesome"
}), awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

                                    awful.key({modkey}, "l", function()
    awful.tag.incmwfact(0.05)
end, {description = "increase master width factor", group = "layout"}),
                                    awful.key({modkey}, "h", function()
    awful.tag.incmwfact(-0.05)
end, {description = "decrease master width factor", group = "layout"}),
                                    awful.key({modkey, "Shift"}, "h",
                                              function()
    awful.tag.incnmaster(1, nil, true)
end, {description = "increase the number of master clients", group = "layout"}),
                                    awful.key({modkey, "Shift"}, "l",
                                              function()
    awful.tag.incnmaster(-1, nil, true)
end, {description = "decrease the number of master clients", group = "layout"}),
                                    awful.key({modkey, "Control"}, "h",
                                              function()
    awful.tag.incncol(1, nil, true)
end, {description = "increase the number of columns", group = "layout"}),
                                    awful.key({modkey, "Control"}, "l",
                                              function()
    awful.tag.incncol(-1, nil, true)
end, {description = "decrease the number of columns", group = "layout"}),
                                    awful.key({modkey}, "space", function()
    awful.layout.inc(1)
end, {description = "select next", group = "layout"}),
                                    awful.key({modkey, "Shift"}, "space",
                                              function() awful.layout.inc(-1) end,
                                              {
    description = "select previous",
    group = "layout"
}), awful.key({modkey, "Control"}, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        client.focus = c
        c:raise()
    end
end, {description = "restore minimized", group = "client"}), -- Prompt
awful.key({modkey}, "r",
          function() awful.screen.focused().mypromptbox:run() end,
          {description = "run prompt", group = "launcher"}), -- Menubar
awful.key({modkey}, "p", function() menubar.show() end,
          {description = "show the menubar", group = "launcher"}),
                                    awful.key({modkey}, "Print", function()
    awful.util.spawn_with_shell(
        "maim -s --hidecursor /tmp/screenshot.png && xclip -selection clipboard /tmp/screenshot.png -t image/png")
end))

local clientkeys = gears.table.join(awful.key({modkey}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {description = "toggle fullscreen", group = "client"}),
                                    awful.key({modkey, "Shift"}, "c",
                                              function(c) c:kill() end, {
    description = "close",
    group = "client"
}), awful.key({modkey, "Control"}, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
                                    awful.key({modkey, "Control"}, "Return",
                                              function(c)
    c:swap(awful.client.getmaster())
end, {description = "move to master", group = "client"}),
                                    awful.key({modkey}, "o", function(c)
    c:move_to_screen()
end, {description = "move to screen", group = "client"}),
                                    awful.key({modkey}, "t", function(c)
    c.ontop = not c.ontop
end, {description = "toggle keep on top", group = "client"}),
                                    awful.key({modkey}, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end, {description = "minimize", group = "client"}),
                                    awful.key({modkey}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {description = "(un)maximize", group = "client"}),
                                    awful.key({modkey, "Control"}, "m",
                                              function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end, {description = "(un)maximize vertically", group = "client"}),
                                    awful.key({modkey, "Shift"}, "m",
                                              function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end, {description = "(un)maximize horizontally", group = "client"}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys, -- View tag only.
    awful.key({modkey}, "#" .. i + 9, function()
        local screenfocus = awful.screen.focused()
        local tag = screenfocus.tags[i]
        if tag then tag:view_only() end
    end, {description = "view tag #" .. i, group = "tag"}),
    -- Toggle tag display.
                                  awful.key({modkey, "Control"}, "#" .. i + 9,
                                            function()
        local screenfocus = awful.screen.focused()
        local tag = screenfocus.tags[i]
        if tag then awful.tag.viewtoggle(tag) end
    end, {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
                                  awful.key({modkey, "Shift"}, "#" .. i + 9,
                                            function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:move_to_tag(tag) end
        end
    end, {description = "move focused client to tag #" .. i, group = "tag"}),
    -- Toggle tag on focused client.
                                  awful.key({modkey, "Control", "Shift"},
                                            "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:toggle_tag(tag) end
        end
    end, {description = "toggle focused client on tag #" .. i, group = "tag"}))
end

local clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    client.focus = c;
    c:raise()
end), awful.button({modkey}, 1, awful.mouse.client.move), awful.button({modkey},
                                                                       3,
                                                                       awful.mouse
                                                                           .client
                                                                           .resize))

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
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    }, -- Add titlebars to normal clients and dialogs
    {rule_any = {class = {"Firefox"}}, properties = {tag = "m"}}, {
        rule_any = {class = {"Signal", "Telegram", "Spotify"}},
        properties = {tag = "x"}
    }, {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = false}
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        client.focus = c
        c:raise()
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        client.focus = c
        c:raise()
        awful.mouse.client.resize(c)
    end))

    awful.titlebar(c):setup{
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and
        awful.client.focus.filter(c) then client.focus = c end
end)

client.connect_signal("focus",
                      function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus",
                      function(c) c.border_color = beautiful.border_normal end)
-- }}}

do
    local apps = {
        {cmd = "firefox", class = "Firefox"},
        {cmd = "signal-desktop", class = "Signal"},
        {cmd = "telegram-desktop", class = "Telegram"},
        {cmd = "potify", class = "Potify"}
    }
    for _, app in pairs(apps) do
        awful.spawn.once(app.cmd, awful.rules.rules, function(c)
            for _, value in pairs(apps) do
                if value.class == c.class then return false end
            end
            return false
        end)
    end
end
