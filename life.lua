--- The game of life module to be used in this Love2D project, handles logic.
-- @module life_logic


local life = {}


--- generates the 2d array to be used with the game
-- It initiates an array with elements like this {{0, 0, 0}},{{0, 0, 0}}
-- @param w table width
-- @param h table height
-- @return a 2d array (table)
function life.generate_2darray(w, h)
    local array = {}
    for i = 1, h do
        array[i]= {}
        for j = 1, w do
            array[i][j] = 0
        end
    end
    return array
end

return life