
-- size of the resulting image
function isogen.calculate_image_size(size, cube_len)
    local width = (size.x * cube_len / 2) + (size.z * cube_len / 2)
    local height = math.max(
        cube_len + ((size.x-1) * (cube_len / 4)),
        cube_len + ((size.z-1) * (cube_len / 4)),
        cube_len + ((size.y-1) * (cube_len / 2))
    )
    -- TODO: wrong calc!

    return width, height
end

-- position offset of the center cube (front, bottom)
-- all other positions are relative to this
function isogen.get_center_cube_offset(size, cube_len, rotation)
    local x = (size.x * cube_len / 2) - (cube_len / 2)
    local max_y = math.max(
        cube_len + ((size.x-1) * (cube_len / 4)),
        cube_len + ((size.z-1) * (cube_len / 4)),
        cube_len + ((size.y-1) * (cube_len / 2))
    )

    local y = max_y - cube_len
    return x, y
end

-- returns the cube position offset relative to the center cube
function isogen.get_cube_position(center_x, center_y, cube_len, rotation, pos)
    local x = center_x - (cube_len / 2 * pos.x) + (cube_len / 2 * pos.z)
    local y = center_y - (cube_len / 2 * pos.y) - (cube_len / 4 * pos.x) - (cube_len / 4 * pos.z)
    return x, y
end

function isogen.probe_position(pos1, pos2, pos, ipos)
    -- TODO
end