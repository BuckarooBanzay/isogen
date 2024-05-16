
mtt.register("draw cube", function(callback)

    local red = { a=255, r=255, g=0, b=0 }
    local green = { a=255, r=0, g=255, b=0 }
    local blue = { a=255, r=0, g=0, b=255 }
    local transparent = { a=0, r=0, g=0, b=0 }

    local width = 800
    local height = 600
    local png_data = {}

    for i=1,width*height do
        png_data[i] = transparent
    end

    isogen.draw_cube(png_data, width, 96, 0, 0, red, green, blue)
    local png = minetest.encode_png(width, height, png_data)

    local path = minetest.get_worldpath() .. "/test.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)