
mtt.register("isogen.rotated_get_node", function(callback)
    local rotated_pos
    local pos1 = vector.new(10,10,10)
    local pos2 = vector.new(20,20,20)
    local get_node = function(p)
        rotated_pos = p
    end

    local rotated_get_node = isogen.rotated_get_node(get_node, 90, pos1, pos2)
    assert(not rotated_pos)
    rotated_get_node(vector.new(10,10,10))
    assert(vector.equals(rotated_pos, vector.new(10,10,20)))

    callback()
end)