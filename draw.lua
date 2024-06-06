
local function clamp(v, min, max)
    if v > max then
        return max
    elseif v < min then
        return min
    else
        return v
    end
end

local function color_adjust(c, v)
    return {
        a = c.a,
        r = clamp(c.r + v, 0, 255),
        g = clamp(c.g + v, 0, 255),
        b = clamp(c.b + v, 0, 255)
    }
end

function isogen.draw(pos1, pos2, opts)
    opts = opts or {}
    opts.cube_len = opts.cube_len or 24
    opts.get_node = opts.get_node or minetest.get_node
    local min, max = vector.sort(pos1, pos2)

    minetest.load_area(min, max)

    local size = vector.add(vector.subtract(max, min), 1)
    local width, height = isogen.calculate_image_size(size, opts.cube_len)
    local center_x, center_y = isogen.get_center_cube_offset(size, opts.cube_len)
    local canvas = isogen.create_canvas(width, height)

    local ipos = vector.new(1, -1, 1)
    local list = {}
    local skip_alpha = not opts.enable_transparency

    -- top layer
    for x=min.x, max.x do
        for z=min.z, max.z do
            isogen.probe_position(min, max, vector.new(x, max.y, z), ipos, list, opts.get_node, skip_alpha)
        end
    end

    -- left layer (without top stride)
    for x=min.x, max.x do
        for y=min.y, max.y-1 do
            isogen.probe_position(min, max, vector.new(x, y, min.z), ipos, list, opts.get_node, skip_alpha)
        end
    end

    -- right layer (without top and left stride)
    for z=min.z+1, max.z do
        for y=min.y, max.y-1 do
            isogen.probe_position(min, max, vector.new(min.x, y, z), ipos, list, opts.get_node, skip_alpha)
        end
    end

    table.sort(list, function(a, b)
        return a.order < b.order
    end)

    for _, entry in ipairs(list) do
        local rel_pos = vector.subtract(entry.pos, min)
        local color = entry.color
        if not opts.enable_transparency then
            -- strip alpha channel from copied color
            color = { r=color.r, g=color.g, b=color.b }
        end
        local x, y = isogen.get_cube_position(center_x, center_y, opts.cube_len, 0, rel_pos)
        assert(color.r, "red component not found in color for node '" .. entry.node.name .. "'")
        assert(color.g, "green component not found in color for node '" .. entry.node.name .. "'")
        assert(color.b, "blue component not found in color for node '" .. entry.node.name .. "'")
        isogen.draw_cube(canvas, opts.cube_len, x, y, color, color_adjust(color, -10), color_adjust(color, 10))
    end

    return canvas:png()
end
