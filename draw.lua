
local function probe_and_add(list, min, max, pos, ipos)
    local node, npos = isogen.probe_position(min, max, pos, ipos)
    if node then
        local rel_pos = vector.subtract(npos, min)
        local rel_max = vector.subtract(max, min)
        local order =
            (rel_pos.y * (rel_max.x * rel_max.z)) +
            (rel_max.x - rel_pos.x) +
            (rel_max.z - rel_pos.z)

        table.insert(list, {
            node = node,
            pos = npos,
            order = order
        })
    end
end

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

function isogen.draw(pos1, pos2, cube_len)
    local min, max = vector.sort(pos1, pos2)
    cube_len = cube_len or 24

    minetest.load_area(min, max)

    local size = vector.add(vector.subtract(max, min), 1)
    local width, height = isogen.calculate_image_size(size, cube_len)
    local center_x, center_y = isogen.get_center_cube_offset(size, cube_len)
    local canvas = isogen.create_canvas(width, height)

    local ipos = vector.new(1, -1, 1)
    local list = {}

    -- top layer
    for x=min.x, max.x do
        for z=min.z, max.z do
            probe_and_add(list, min, max, vector.new(x, max.y, z), ipos)
        end
    end

    -- left layer (without top stride)
    for x=min.x, max.x do
        for y=min.y, max.y-1 do
            probe_and_add(list, min, max, vector.new(x, y, min.z), ipos)
        end
    end

    -- right layer (without top and left stride)
    for z=min.z+1, max.z do
        for y=min.y, max.y-1 do
            probe_and_add(list, min, max, vector.new(min.x, y, z), ipos)
        end
    end

    table.sort(list, function(a, b)
        return a.order < b.order
    end)

    for _, entry in ipairs(list) do
        local rel_pos = vector.subtract(entry.pos, min)
        local color = isogen.get_color(entry.node)
        if color then
            local x, y = isogen.get_cube_position(center_x, center_y, cube_len, 0, rel_pos)
            isogen.draw_cube(canvas, cube_len, x, y, color, color_adjust(color, -10), color_adjust(color, 10))
        end
    end

    return canvas:png()
end
