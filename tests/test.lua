-- Uses testy for minimal testing
local life = require 'life'
local game_table = life.generate_2darray(10, 10)
life.set_cell(game_table, 5, 4, 1)

-- luacheck: no unused
local function test_all_values_in_generate_2darray()
    w = 10
    h = 9
    array = life.generate_2darray(w, h)
    wrong = false
    for i = 1, h do
        for j = 1, w do
            if array[i][j] ~= 0 then
                wrong = true
            end
        end
    end
    assert(not wrong, "all elments must be 0")
end

local function test_get_neighbour_function()
    neighbours = life.get_neighbours(game_table, 5, 5)
    sum = 0
    for i, v in pairs(neighbours) do
        sum = sum + v
    end
    assert(sum == 1)
end