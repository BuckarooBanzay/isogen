local pos1 = vector.new(100,100,100)
local pos2 = vector.add(pos1, 15)

mtt.emerge_area(pos1, pos2)

mtt.register("draw", function(callback)
    minetest.load_area(pos1, pos2)

    minetest.set_node(pos1, { name = "mapgen_stone" })
    local node = minetest.get_node(pos1)
    assert(node.name ~= "air")
    assert(node.name ~= "ignore")

    local png = isogen.draw(pos1, pos2)
    local path = minetest.get_worldpath() .. "/test_draw.png"
    minetest.safe_file_write(path, png)

    print("png saved: " .. #png .. " bytes")

    callback()
end)