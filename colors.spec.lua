
mtt.register("get_color", function(callback)
    local c = isogen.get_color({ name = "default:stone" })
    assert(c.r == 91)
    assert(c.g == 88)
    assert(c.b == 87)

    c = isogen.get_color({ name="unifiedbricks:brickblock", param2=1 })
    assert(c.r == 255)
    assert(c.g == 207)
    assert(c.b == 191)

    c = isogen.get_color({ name="homedecor:piano" })
    assert(c.r == 61)
    assert(c.g == 61)
    assert(c.b == 61)

    c = isogen.get_color("stuff")
    assert(not c)

    assert(isogen.get_color("scifi_nodes:rock"))
    assert(isogen.get_color("pick_and_place:handle"))

    callback();
end)