local pos1 = vector.new(100,100,100)
local pos2 = vector.add(pos1, 4)

mtt.emerge_area(pos1, pos2)

mtt.register("draw", function(callback)
    minetest.load_area(pos1, pos2)

    minetest.set_node(pos1, { name = "mapgen_stone" })
    for x=0,2 do
        for z=0,2 do
            minetest.set_node(vector.add(pos1, vector.new(z, 0, x)), { name = "mapgen_stone" })
        end
    end
    minetest.set_node(vector.add(pos1, vector.new(0, 1, 0)), { name = "mapgen_water_source" })
    minetest.set_node(vector.add(pos1, vector.new(0, 2, 0)), { name = "mapgen_water_source" })
    minetest.set_node(vector.add(pos1, vector.new(1, 1, 0)), { name = "mapgen_water_source" })

    -- sanity tests
    local node = minetest.get_node(pos1)
    assert(node.name ~= "air")
    assert(node.name ~= "ignore")

    local png = isogen.draw(pos1, pos2, {
        side_len = 48
    })
    local path = minetest.get_worldpath() .. "/test_draw.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)