
local function flip_pos(rel_pos, max, axis)
	rel_pos[axis] = max[axis] - rel_pos[axis]
end

local function transpose_pos(rel_pos, axis1, axis2)
	rel_pos[axis1], rel_pos[axis2] = rel_pos[axis2], rel_pos[axis1]
end

local function rotate_pos(rel_pos, max_pos, rotation_y)
	local new_pos = {x=rel_pos.x, y=rel_pos.y, z=rel_pos.z}
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

function isogen.rotate_size(size, rotation_y)
	local new_size = {x=size.x, y=size.y, z=size.z}
	if rotation_y == 90 or rotation_y == 270 then
		-- swap x and z axes
		transpose_pos(new_size, "x", "z")
	end
	return new_size
end

function isogen.rotated_get_node(get_node, rotation, pos1, pos2)
    if rotation == 0 then
        return get_node
    end

    pos1, pos2 = vector.sort(pos1, pos2)
    local max = vector.subtract(pos2, pos1)

    return function(pos)
        local rel_pos = vector.subtract(pos, pos1)
        local rotated_pos = rotate_pos(rel_pos, max, rotation)
        local offset_pos = vector.add(rotated_pos, pos1)
        return get_node(offset_pos)
    end
end