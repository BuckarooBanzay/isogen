
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

function isogen.probe_position(min, max, pos, ipos, list, get_node)
    while vector.in_area(pos, min, max) do
        local node = get_node(pos)
        local color = isogen.get_color(node)
        if color then
            local rel_pos = vector.subtract(pos, min)
            local rel_max = vector.subtract(max, min)
            local order =
                (rel_pos.y * (rel_max.x * rel_max.z)) +
                (rel_max.x - rel_pos.x) +
                (rel_max.z - rel_pos.z)

            table.insert(list, {
                pos = pos,
                color = color,
                order = order,
                node = node
            })

            if not color.a or color.a == 255 then
                -- solid color
                break
            end
        end
        pos = vector.add(pos, ipos)
    end
end

local function flip_pos(pos, max, axis)
	pos[axis] = max[axis] - pos[axis]
end

local function transpose_pos(pos, axis1, axis2)
	pos[axis1], pos[axis2] = pos[axis2], pos[axis1]
end

function isogen.rotate_pos(pos, max_pos, rotation_y)
	local new_pos = vector.new(pos.x, pos.y, pos.z)
	if rotation_y == 90 then
		flip_pos(new_pos, max_pos, "x")
		transpose_pos(new_pos, "x", "z")
	elseif rotation_y == 180 then
		flip_pos(new_pos, max_pos, "x")
		flip_pos(new_pos, max_pos, "z")
	elseif rotation_y == 270 then
		flip_pos(new_pos, max_pos, "z")
		transpose_pos(new_pos, "x", "z")
	end
	return new_pos
end