
-- size of the resulting image
function isogen.calculate_image_size(size, cube_len)
    local width =
        (size.x * cube_len / 2) +
        (size.z * cube_len / 2)
    local height =
        (size.x * cube_len / 4) +
        (size.y * cube_len / 2) +
        (size.z * cube_len / 4)

    return width, height
end

-- position offset of the center cube (front, bottom)
-- all other positions are relative to this
function isogen.get_center_cube_offset(size, cube_len)
    local x =
        (size.z * cube_len / 2) -
        (cube_len / 2)
    local y =
        (size.x * cube_len / 4) +
        (size.y * cube_len / 2) +
        (size.z * cube_len / 4) -
        cube_len

    return x, y
end

-- returns the cube position offset relative to the center cube
function isogen.get_cube_position(center_x, center_y, cube_len, _, pos)
    local x = center_x -
        (pos.z * cube_len / 2) +
        (pos.x * cube_len / 2)
    local y = center_y -
        (pos.x * cube_len / 4) -
        (pos.y * cube_len / 2) -
        (pos.z * cube_len / 4)

    return x, y
end

function isogen.probe_position(min, max, pos, ipos)
    while vector.in_area(pos, min, max) do
        local node = minetest.get_node(pos)
        if node.name ~= "air" and node.name ~= "ignore" then
            return node, pos
        end
        pos = vector.add(pos, ipos)
    end
end