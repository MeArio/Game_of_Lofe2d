--- The game of life module to be used in this Love2D project, handles logic.
-- @module life_logic

local life = {}


------------------------------------------------------------------------------------------------------
--- generates the 2d array to be used with the game
-- It initiates an array with elements like this {{0, 0, 0}},{{0, 0, 0}}
-- @param w table width
-- @param h table height
-- @return a 2d array (table)
------------------------------------------------------------------------------------------------------
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


------------------------------------------------------------------------------------------------------
--- returns the cell value at x, y
-- @param array game data array
-- @param x x coordinate for array
-- @param y y coordinate for array
-- @return cell value
------------------------------------------------------------------------------------------------------
function life.get_cell(array, x, y)
    return array[y][x]
end


------------------------------------------------------------------------------------------------------
--- sets the value of the cell at x, y
-- @param array game data array
-- @param x x coordinate of the cell
-- @param y y coordinate of the cell
-- @param value value to be set
------------------------------------------------------------------------------------------------------
function life.set_cell(array, x, y, value)
    array[y][x] = value
end


------------------------------------------------------------------------------------------------------
--- gives you all the neighbours of a cell in a table
-- solution from stack overflow
-- @param table array for the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return table with all the neighbours
------------------------------------------------------------------------------------------------------
function life.get_neighbours(array, x, y)
    neighbours = {}
    row_limit = #array
    if row_limit > 0 then
            collumn_limit = #array[1]
            for xcol=math.max(1, x-1),  math.min(x+1, row_limit) do
                for ycol=math.max(1, y-1), math.min(y+1, collumn_limit) do
                    if (x ~= xcol) or (y ~= ycol) then
                        table.insert(neighbours, life.get_cell(array, xcol, ycol))
                    end
                end
            end
    end
    return neighbours
end


------------------------------------------------------------------------------------------------------
--- returns true if the cell is under populated and false otherwise
-- if the cell has less than 2 live neighbours it is underpopulated
-- @param table array for the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return boolean
------------------------------------------------------------------------------------------------------
function life.under_population_check(array, x, y)
    neighbours = life.get_neighbours(array, x, y)
    alive = 0
    for _, state in pairs(neighbours) do
        if state == 1 then
            alive = alive + 1
        end
    end
    if alive < 2 then
        return true
    else
        return false
    end
end

return life