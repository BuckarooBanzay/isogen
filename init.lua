isogen = {}

local MP = minetest.get_modpath("isogen")
dofile(MP.."/common.lua")
dofile(MP.."/colors.lua")
dofile(MP.."/canvas.lua")
dofile(MP.."/draw_cube.lua")
dofile(MP.."/draw_map.lua")
dofile(MP.."/draw.lua")

if minetest.get_modpath("worldedit_commands") then
    dofile(MP.."/chatcommand.lua")
end

if minetest.get_modpath("mtt") and mtt.enabled then
    dofile(MP.."/common.spec.lua")
    dofile(MP.."/colors.spec.lua")
    dofile(MP.."/draw_cube.spec.lua")
    dofile(MP.."/draw.spec.lua")
end