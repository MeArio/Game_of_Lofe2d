-- Uses shake for minimal testing
life = require 'life'


local function test_all_values_in_generate_2darray()
    w = 10
    h = 9
    array = life.generate_2darray(w, h)
    for i = 1, h do
        for j = 1, w do
            assert(array[i][j] == 0,"all elements should be 0")
        end
    end
end
