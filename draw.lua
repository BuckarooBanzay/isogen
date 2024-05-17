-- x and y are 0-based
local function get_index(w, x, y)
    return (w * y) + x + 1
end

function isogen.draw_cube(data, width, cube_len, x_offset, y_offset, color1, color2, color3)
    assert(cube_len % 4 == 0, "cube_len must be divisible by 4")
    assert(cube_len > 4, "cube_len must be greater than 4")

    local half_len_zero_indexed = (cube_len/2)-1
    local quarter_len = cube_len / 4

    -- left/right part
    local yo = 0
    for x=0,half_len_zero_indexed do
        for y=0,half_len_zero_indexed do
            -- left
            local index = get_index(width, x_offset+x, y_offset+y+quarter_len+yo)
            data[index] = color1
            -- right
            index = get_index(width, x_offset+cube_len-1-x, y_offset+y+quarter_len+yo)
            data[index] = color2
        end
        if x % 2 == 0 then
            yo = yo + 1
        end
    end

    -- upper part
    yo = 0
    local yl = 1
    for x=0,half_len_zero_indexed-1 do
        for y=0,yl do
            -- left
            local index = get_index(width, x_offset+1+x, y_offset+quarter_len-1-yo+y)
            data[index] = color3
            -- right
            index = get_index(width, x_offset+cube_len-2-x, y_offset+quarter_len-1-yo+y)
            data[index] = color3
        end
        if x % 2 ~= 0 then
            yo = yo + 1
            yl = yl + 2
        end
    end
end

-- image width: (x * cube_len / 2) + (z * cube_len / 2)
-- image height: Math.max(
--    cube_len + ((x-1) * (cube_len / 4)),
--    cube_len + ((z-1) * (cube_len / 4))),
--    cube_len + ((y-1) * (cube_len / 2))
--)
