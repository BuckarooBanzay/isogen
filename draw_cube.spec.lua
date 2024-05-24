
mtt.register("draw_cube", function(callback)

    local red = { a=255, r=255, g=0, b=0 }
    local green = { a=255, r=0, g=255, b=0 }
    local blue = { a=255, r=0, g=0, b=255 }

    local canvas = isogen.create_canvas(800, 600)

    isogen.draw_cube(canvas, 24, 0, 0, red, green, blue, minetest.get_node)
    local png = canvas:png()

    local path = minetest.get_worldpath() .. "/test.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)