local transparent = { a=0, r=0, g=0, b=0 }

local Canvas = {}
local Canvas_mt = { __index = Canvas }

-- x and y is 0-based
function Canvas:get_index(x, y)
    return (self.width * y) + x + 1
end

-- add pixel with transparency
function Canvas:add_pixel(x, y, fg)
    if not fg.a or fg.a == 255 then
        -- solid color, no transparency
        return self:set_pixel(x, y, fg)
    end

    local i = self:get_index(x, y)
    local bg = self.png_data[i]
    local a = fg.a / 255
    local ai = 1 - a

    self.png_data[i] = {
        r = ((fg.r * a) + (bg.r * ai)),
        g = ((fg.g * a) + (bg.g * ai)),
        b = ((fg.b * a) + (bg.b * ai)),
        a = math.max(bg.a or 255, fg.a)
    }
end

-- set a pixel
function Canvas:set_pixel(x, y, colorspec)
    local i = self:get_index(x, y)
    self.png_data[i] = colorspec
end

function Canvas:get_pixel(x, y)
    local i = self:get_index(x, y)
    return self.png_data[i]
end

function Canvas:png()
    return minetest.encode_png(self.width, self.height, self.png_data)
end

function isogen.create_canvas(width, height)
    local png_data = {}
    for i=1,width*height do
        png_data[i] = transparent
    end

    local self = {
        png_data = png_data,
        width = width,
        height = height
	}
	return setmetatable(self, Canvas_mt)
end