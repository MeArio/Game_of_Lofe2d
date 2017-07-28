local argparse = require 'libs.argparse'
local parser = argparse()
parser:argument("dir", "love dir") -- This is here because the parser freaks out because of the love command folder path
parser:option("-s --scale", "Game scale", 10)
parser:option("-w --width", "Game width", 32)
parser:option("-h --height", "Game height", 24)
local args = parser:parse()

-- luacheck: globals love
function love.load()

end

function love.update(dt)

end

function love.draw()

end