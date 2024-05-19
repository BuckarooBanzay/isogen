
function isogen.draw_cube(canvas, cube_len, x_offset, y_offset, color1, color2, color3)
    assert(cube_len % 4 == 0, "cube_len must be divisible by 4")
    assert(cube_len > 4, "cube_len must be greater than 4")

    local half_len_zero_indexed = (cube_len/2)-1
    local quarter_len = cube_len / 4

    -- left/right part
    local yo = 0
    for x=0,half_len_zero_indexed do
        for y=0,half_len_zero_indexed do
            -- left
            canvas:set_pixel(x_offset+x, y_offset+y+quarter_len+yo, color1)
            -- right
            canvas:set_pixel(x_offset+cube_len-1-x, y_offset+y+quarter_len+yo, color2)
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
            canvas:set_pixel(x_offset+1+x, y_offset+quarter_len-1-yo+y, color3)
            -- right
            canvas:set_pixel(x_offset+cube_len-2-x, y_offset+quarter_len-1-yo+y, color3)
        end
        if x % 2 ~= 0 then
            yo = yo + 1
            yl = yl + 2
        end
    end
end

