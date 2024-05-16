isogen = {}

local MP = minetest.get_modpath("isogen")
dofile(MP.."/draw.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    dofile(MP.."/draw.spec.lua")
end