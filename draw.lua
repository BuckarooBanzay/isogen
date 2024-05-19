
function isogen.draw(pos1, pos2, rotation, cube_len)
    pos1, pos2 = vector.sort(pos1, pos2)
    rotation = rotation or 0
    cube_len = cube_len or 24

    local size = vector.add(vector.subtract(pos2, pos1), 1)
    local width, height = isogen.calculate_image_size(size, cube_len)
    local canvas = isogen.create_canvas(width, height)

    return canvas:png()
end
