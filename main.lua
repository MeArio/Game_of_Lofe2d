local argparse = require 'libs.argparse'
local life = require 'life'
local parser = argparse()
parser:argument("dir", "love dir") -- This is here because the parser freaks out because of the love command folder path
parser:option("-s --scale", "Game scale", 10)
parser:option("-w --width", "Game width", 32)
parser:option("-a --altheight", "Game height", 24)
local args = parser:parse()

-- luacheck: globals love
local function mouse_place()
    local x, y = love.mouse.getPosition()
    local grid_x = math.ceil(x / args.scale)
    local grid_y = math.ceil(y / args.scale)
    if love.mouse.isDown(1) then
        gamestate = 'paused'
        life.set_cell(gt, grid_x, grid_y, 1)
    end
    if love.mouse.isDown(2) then
        gamestate = 'paused'
        life.set_cell(gt, grid_x, grid_y, 0)
    end
end

function love.load()
    love.window.setMode((args.width) * args.scale, (args.altheight) * args.scale)
    gt = life.generate_2darray(args.width, args.altheight)
    TIME_BETWEEN_TICKS = 0.1
    timer = TIME_BETWEEN_TICKS
    gamestate = 'paused'
end

function love.update(dt)
    mouse_place()
    if gamestate == 'playing' then
        timer = timer - dt
        if timer <= 0 then
            gt = life.step_a_generation(gt)
            timer = TIME_BETWEEN_TICKS
        end
    end
end

function love.draw()
    life.draw_table(gt, args.scale)
end

function love.keypressed(key)
    if key == 'p' then
        if gamestate == 'playing' then
            gamestate = 'paused'
        elseif gamestate == 'paused' then
                gamestate = 'playing'
        end
    end
    if key == 'n' then
        gt = life.step_a_generation(gt)
    end
end