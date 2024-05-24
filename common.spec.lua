
mtt.register("calculate_image_size", function(callback)
    local size = vector.new(10, 10, 10)
    local cube_len = 24
    local width, height = isogen.calculate_image_size(size, cube_len)
    assert(width == 240)
    assert(height == 240)

    size = vector.new(1, 1, 1)
    cube_len = 24
    width, height = isogen.calculate_image_size(size, cube_len)
    assert(width == cube_len)
    assert(height == cube_len)
    callback()
end)

mtt.register("get_center_cube_offset", function(callback)
    local size = vector.new(10, 10, 10)
    local cube_len = 24
    local rotation = 0
    local x, y = isogen.get_center_cube_offset(size, cube_len, rotation)
    assert(x == 108)
    assert(y == 240 - cube_len)

    size = vector.new(1, 1, 1)
    x, y = isogen.get_center_cube_offset(size, cube_len, rotation)
    assert(x == 0)
    assert(y == 0)

    callback()
end)

mtt.register("get_cube_position", function(callback)
    local size = vector.new(10, 10, 10)
    local cube_len = 24
    local rotation = 0
    local center_x, center_y = isogen.get_center_cube_offset(size, cube_len, rotation)

    local pos = vector.new(0, 0, 0)
    local x, y = isogen.get_cube_position(center_x, center_y, cube_len, rotation, pos)
    assert(x == 108)
    assert(y == 240 - cube_len)

    pos = vector.new(0, 1, 0)
    x, y = isogen.get_cube_position(center_x, center_y, cube_len, rotation, pos)
    assert(x == 108)
    assert(y == 240 - cube_len - (cube_len / 2))

    pos = vector.new(1, 1, 0)
    x, y = isogen.get_cube_position(center_x, center_y, cube_len, rotation, pos)
    assert(x == 108 + (cube_len / 2))
    assert(y == 240 - cube_len - (cube_len / 2) - (cube_len / 4))

    pos = vector.new(9, 9, 9)
    x, y = isogen.get_cube_position(center_x, center_y, cube_len, rotation, pos)
    assert(x == 108)
    assert(y == 0)

    callback()
end)

mtt.register("probe_position", function(callback)
    local pos1 = vector.new(0, 0, 0)
    local pos2 = vector.new(15, 15, 15)
    local pos = vector.new(0, 15, 0)
    local ipos = vector.new(1, -1, 1)

    isogen.probe_position(pos1, pos2, pos, ipos, {}, minetest.get_node)
    callback()
end)