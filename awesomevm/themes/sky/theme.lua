-------------------------------
--    "Sky" awesome theme    --
--  By Andrei "Garoth" Thorp --
-------------------------------
-- If you want SVGs and extras, get them from garoth.com/awesome/sky-theme


local home    = os.getenv("HOME")
local awesome_config = home .. "/.config/awesome"

-- BASICS
theme = {}
theme.font          = "sans 8"

theme.bg_focus      = "#e2eeea"
theme.bg_normal     = "#729fcf"
theme.bg_urgent     = "#fce94f"
theme.bg_minimize   = "#0067ce"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#2e3436"
theme.fg_focus      = "#2e3436"
theme.fg_urgent     = "#2e3436"
theme.fg_minimize   = "#2e3436"

theme.border_width  = 2
theme.border_normal = "#dae3e0"
theme.border_focus  = "#729fcf"
theme.border_marked = "#eeeeec"

-- IMAGES
theme.layout_fairh           = awesome_config .. "/themes/sky/layouts/fairh.png"
theme.layout_fairv           = awesome_config .. "/themes/sky/layouts/fairv.png"
theme.layout_floating        = awesome_config .. "/themes/sky/layouts/floating.png"
theme.layout_magnifier       = awesome_config .. "/themes/sky/layouts/magnifier.png"
theme.layout_max             = awesome_config .. "/themes/sky/layouts/max.png"
theme.layout_fullscreen      = awesome_config .. "/themes/sky/layouts/fullscreen.png"
theme.layout_tilebottom      = awesome_config .. "/themes/sky/layouts/tilebottom.png"
theme.layout_tileleft        = awesome_config .. "/themes/sky/layouts/tileleft.png"
theme.layout_tile            = awesome_config .. "/themes/sky/layouts/tile.png"
theme.layout_tiletop         = awesome_config .. "/themes/sky/layouts/tiletop.png"
theme.layout_spiral          = awesome_config .. "/themes/sky/layouts/spiral.png"
theme.layout_dwindle         = awesome_config .. "/themes/sky/layouts/dwindle.png"

theme.awesome_icon           = awesome_config .. "/themes/sky/awesome-icon.png"

-- from default for now...
theme.menu_submenu_icon     = awesome_config .. "/themes/default/submenu.png"
theme.taglist_squares_sel   = awesome_config .. "/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = awesome_config .. "/themes/default/taglist/squarew.png"

-- MISC
theme.wallpaper             = awesome_config .. "/themes/sky/sky-background.png"
theme.taglist_squares       = "true"
theme.titlebar_close_button = "true"
theme.menu_height           = 15
theme.menu_width            = 100

-- Define the image to load
theme.titlebar_close_button_normal = awesome_config .. "/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = awesome_config .. "/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = awesome_config .. "/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = awesome_config .. "/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = awesome_config .. "/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = awesome_config .. "/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = awesome_config .. "/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = awesome_config .. "/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = awesome_config .. "/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = awesome_config .. "/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = awesome_config .. "/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = awesome_config .. "/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = awesome_config .. "/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = awesome_config .. "/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = awesome_config .. "/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = awesome_config .. "/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = awesome_config .. "/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = awesome_config .. "/themes/default/titlebar/maximized_focus_active.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
