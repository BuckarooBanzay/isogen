
function isogen.draw_map(pos1, pos2, opts)
    opts = opts or {}
    opts.get_node = opts.get_node or minetest.get_node
    pos1, pos2 = vector.sort(pos1, pos2)

    minetest.load_area(pos1, pos2)

    local height = pos2.z - pos1.z + 1
    local width = pos2.x - pos1.x + 1

    local canvas = isogen.create_canvas(width, height)

    -- left-right
    for x=pos1.x,pos2.x do
        -- top-down
        for z=pos1.z,pos2.z do
            local list = {}

            -- up-down
            for y=pos2.y,pos1.y,-1 do
                local pos = vector.new(x, y, z)
                local node = opts.get_node(pos)
                local color = isogen.get_color(node)
                if color then
                    table.insert(list, color)
                    if not color.a or color.a == 255 then
                        break
                    end
                end
            end

            -- draw from bottom-up (transparency)
            if #list > 0 then
                local pos = vector.new(x, 0, z)
                for i=#list,1,-1 do
                    local rel_pos = vector.subtract(pos, pos1)
                    local cx = width - rel_pos.x - 1 -- inverted x axis
                    local cy = rel_pos.z
                    canvas:add_pixel(cx, cy, list[i])
                end
            end
        end
    end

    return canvas:png()
end