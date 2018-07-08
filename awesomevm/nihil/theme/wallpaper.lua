local gears     = require("gears")
local beautiful = require("beautiful")

local wallpaper = {}

function wallpaper.set_wallpaper(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

return wallpaper
