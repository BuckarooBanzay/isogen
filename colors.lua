-- nodename -> {r,g,b,a}
local node_colors = {}

-- nodename -> { {r,g,b,a}, {...}, ... }
local palette_colors = {}

-- palette-name -> def
local palettes = {}

local MP = minetest.get_modpath("isogen")
local function parse_file(filename)
    for line in io.lines(filename) do
        if #line > 2 and line:sub(1,1) ~= "#" then
            local i = 1
            local name
            local color = {}
            for str in string.gmatch(line, "([^ ]+)") do
                if i == 1 then name = str end
                if i == 2 then color.r = tonumber(str) end
                if i == 3 then color.g = tonumber(str) end
                if i == 4 then color.b = tonumber(str) end
                if i == 5 and #str > 0 then color.a = tonumber(str) end

                i = i + 1
            end
            node_colors[name] = color
        end
    end
end

local function parse_palette(name)
    local f = assert(io.open(MP .. "/colors/" .. name .. ".json", "rb"))
    local content = f:read("*all")
    f:close()
    local def = minetest.parse_json(content)
    palettes[name] = def

    for line in io.lines(MP .. "/colors/" .. name .. ".txt") do
        if #line > 2 and line:sub(1,1) ~= "#" then
            palette_colors[line] = def
        end
    end
end

local function parse_mapcolors()
    for name, def in pairs(minetest.registered_nodes) do
        -- mapcolor attribute
        if def.mapcolor then
            node_colors[name] = def.mapcolor
        end

        -- unifieddyes palette
        if def.palette and def.palette == "unifieddyes_palette_extended.png" then
            node_colors[name] = nil
            palette_colors[name] = palettes["unifieddyes_palette_extended"]
        end
    end
end

local function init()
    parse_file(MP .. "/colors/" .. "advtrains.txt")
    parse_file(MP .. "/colors/" .. "everness.txt")
    parse_file(MP .. "/colors/" .. "mc2.txt")
    parse_file(MP .. "/colors/" .. "miles.txt")
    parse_file(MP .. "/colors/" .. "mtg.txt")
    parse_file(MP .. "/colors/" .. "naturalbiomes.txt")
    parse_file(MP .. "/colors/" .. "nodecore.txt")
    parse_file(MP .. "/colors/" .. "scifi_nodes.txt")
    parse_file(MP .. "/colors/" .. "vanessa.txt")
    parse_file(MP .. "/colors/" .. "void.txt")
    parse_palette("unifieddyes_palette_extended")
    parse_mapcolors()

    -- check for world-specific colors.txt file
    local world_colors_filename = minetest.get_worldpath() .. "/colors.txt"
    if io.open(world_colors_filename) then
        parse_file(world_colors_filename)
    end
end

local is_initialized = false
function isogen.get_color(node)
    if not is_initialized then
        init()
        is_initialized = true
    end

    if palette_colors[node.name] and node.param2 and node.param2 > 0 then
        -- param2 colored
        return palette_colors[node.name][node.param2+1]
    end

    if node_colors[node.name] then
        -- simple color
        return node_colors[node.name]
    end

end