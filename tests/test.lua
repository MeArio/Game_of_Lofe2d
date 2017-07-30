-- Uses testy for minimal testing
local life = require 'life'


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
    game_table = life.generate_2darray(10, 10)
    life.set_cell(game_table, 5, 4, 1)

    neighbours = life.get_neighbours(game_table, 5, 5)
    sum = 0
    for i, v in pairs(neighbours) do
        sum = sum + v
    end
    assert(sum == 1)
end

local function test_get_neighbour_out_of_bounds()
    game_table = life.generate_2darray(10, 10)
    life.set_cell(game_table, 1, 2, 1)
    neighbours = life.get_neighbours(game_table, 1, 1)
    sum = 0
    for i, v in pairs(neighbours) do
        sum = sum + v
    end
    assert(sum == 1)
end

local function test_true_if_underpopulated()
    game_table = life.generate_2darray(10,10)
    assert(life.under_population_check(game_table, 1, 1) == true)
end

local function test_false_if_not_underpopulated()
    game_table = life.generate_2darray(10,10)
    life.set_cell(game_table, 1, 2, 1)
    life.set_cell(game_table, 2, 1, 1)
    assert(life.under_population_check(game_table, 1, 1) == false)
end