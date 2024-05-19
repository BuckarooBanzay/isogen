isogen = {}

local MP = minetest.get_modpath("isogen")
dofile(MP.."/colors.lua")
dofile(MP.."/canvas.lua")
dofile(MP.."/draw_cube.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    dofile(MP.."/colors.spec.lua")
    dofile(MP.."/draw_cube.spec.lua")
end