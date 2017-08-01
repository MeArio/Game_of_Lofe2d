local argparse = require 'libs.argparse'
local life = require 'life'
local inspect = require 'libs.inspect'
local parser = argparse()
parser:argument("dir", "love dir") -- This is here because the parser freaks out because of the love command folder path
parser:option("-s --scale", "Game scale", 10)
parser:option("-w --width", "Game width", 32)
parser:option("-h --height", "Game height", 24)
local args = parser:parse()

-- luacheck: globals love

function love.load()
    gt = life.generate_2darray(32, 24)
    life.set_cell(gt, 2, 1, 1)
    life.set_cell(gt, 2, 2, 1)
    life.set_cell(gt, 2, 3, 1)
    print(inspect(gt))
    gt = life.step_a_generation(gt)

end

function love.update(dt)

end

function love.draw()
    life.draw_table(gt, args.scale)
end