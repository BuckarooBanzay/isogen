mtt.register("draw", function(callback)
    local pos1 = vector.new(0,0,0)
    local pos2 = vector.new(15, 15, 15)

    local png = isogen.draw(pos1, pos2)
    local path = minetest.get_worldpath() .. "/test_draw.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)