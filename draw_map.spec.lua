local pos1 = vector.new(200,100,100)
local pos2 = vector.add(pos1, 15)

mtt.emerge_area(pos1, pos2)

mtt.register("draw_map", function(callback)
    minetest.load_area(pos1, pos2)

    minetest.set_node(pos1, { name = "mapgen_stone" })
    minetest.set_node(vector.add(pos1, vector.new(1, 0, 0)), { name = "mapgen_stone" })
    minetest.set_node(vector.add(pos1, vector.new(2, 0, 0)), { name = "mapgen_stone" })
    minetest.set_node(vector.add(pos1, vector.new(0, 1, 0)), { name = "mapgen_water_source" })
    minetest.set_node(vector.add(pos1, vector.new(1, 0, 1)), { name = "mapgen_water_source" })

    -- sanity tests
    local node = minetest.get_node(pos1)
    assert(node.name ~= "air")
    assert(node.name ~= "ignore")

    local png = isogen.draw_map(pos1, pos2)
    local path = minetest.get_worldpath() .. "/test_map.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)