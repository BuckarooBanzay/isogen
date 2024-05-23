
worldedit.register_command("isogen", {
    params = "[filename]",
    description = "Generate an isometric image of the world region",
    privs = {worldedit=true},
    require_pos = 2,
    parse = function(param)
        return true, param
    end,
    func = function(name, filename)
        local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
        if not filename or filename == "" then
            return false, "please specify a filename"
        end

        minetest.load_area(pos1, pos2)
        local png = isogen.draw(pos1, pos2)
        local path = minetest.get_worldpath() .. "/" .. filename .. ".png"
        minetest.safe_file_write(path, png)

        return true, "png saved: " .. #png .. " bytes"
    end
})

worldedit.register_command("isogen_map", {
    params = "[filename]",
    description = "Generate a map image of the world region",
    privs = {worldedit=true},
    require_pos = 2,
    parse = function(param)
        return true, param
    end,
    func = function(name, filename)
        local pos1, pos2 = worldedit.pos1[name], worldedit.pos2[name]
        if not filename or filename == "" then
            return false, "please specify a filename"
        end

        minetest.load_area(pos1, pos2)
        local png = isogen.draw_map(pos1, pos2)
        local path = minetest.get_worldpath() .. "/" .. filename .. ".png"
        minetest.safe_file_write(path, png)

        return true, "png saved: " .. #png .. " bytes"
    end
})