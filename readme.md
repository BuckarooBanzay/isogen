
# isogen

![](https://github.com/buckaroobanzay/isogen/workflows/luacheck/badge.svg)
![](https://github.com/buckaroobanzay/isogen/workflows/test/badge.svg)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/buckaroobanzay/isogen)
[![Coverage Status](https://coveralls.io/repos/github/BuckarooBanzay/isogen/badge.svg?branch=master)](https://coveralls.io/github/BuckarooBanzay/isogen?branch=master)


Generate isometric images from ingame builds

![](./isogen.png)

# Commands

If the `worldedit` mod is present you can use the following command to render the current we-region to a png-file:

```
//isogen [filename]
```

**NOTE**: larger regions require more memory

# Colors

Supported node-colors:
* colors.txt files in the `/colors` directory
* palette-support for `unifieddyes_palette_extended`
* `mapcolor` node definition
* `colors.txt` file in the world-directory (if found)

# Api

## `isogen.draw(pos1, pos2, opts?)`

Renders an isometric image and returns the png data

Example:
```lua
local pos1 = vector.new(0,0,0)
local pos2 = vector.new(16,16,16) -- NOTE: larger regions require more memory
local opts = { -- optional
    cube_len = 24, -- optional: multiple of 4 and greater than 4 pixels
    enable_transparency = false, -- optional/experimental: enable transparency
    get_node = minetest.get_node -- optional: the get_node() function to use
}

-- render and save to world-directory
local png = isogen.draw(pos1, pos2, opts)
local path = minetest.get_worldpath() .. "/iso.png"
minetest.safe_file_write(path, png)
```

## `isogen.draw_map(pos1, pos2, opts?)`

Renders a map image and returns the png data

Example:
```lua
local pos1 = vector.new(0,0,0)
local pos2 = vector.new(16,16,16) -- NOTE: larger regions require more memory
local opts = { -- optional
    get_node = minetest.get_node -- optional: the get_node() function to use
}

-- render and save to world-directory
local png = isogen.draw_map(pos1, pos2, opts)
local path = minetest.get_worldpath() .. "/map.png"
minetest.safe_file_write(path, png)
```

## `isogen.create_canvas(width, height)`

Creates a canvas to set and get pixels

Example:
```lua
-- create a canvas, draw a pixel on the coords 0,0 and save the png to the world-directory
local c = isogen.create_canvas(240, 160)
c:set_pixel(0, 0, { r=255, g=0, b=0, a=0 })

local png = c:png()
local path = minetest.get_worldpath() .. "/iso.png"
minetest.safe_file_write(path, png)
```

# License

* Code: `MIT`