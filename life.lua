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
-- I couldn't wrap my mind around proper coding of a
-- function like this so I did it the dumb way, will have to fix it, bad function
-- @param array the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return table with all the neighbours (not in any order)
------------------------------------------------------------------------------------------------------
function life.get_neighbours(array, x, y)
    width = #array[1]
    height = #array
    neighbours = {}
    if x - 1 >= 0 then
        table.insert(neighbours, life.get_cell(array, x - 1, y))
        if y - 1 >= 0 then
            table.insert(neighbours, life.get_cell(array, x - 1,  y - 1))
        end
        if y + 1 <= height then
            table.insert(neighbours, life.get_cell(array, x - 1, y + 1))
        end
    end

    if x + 1 <= width then
        table.insert(neighbours, life.get_cell(array, x + 1, y))
        if y - 1 >= 0 then
            table.insert(neighbours, life.get_cell(array, x + 1, y - 1))
        end
        if y + 1 <= height then
            table.insert(neighbours, life.get_cell(array, x + 1, y + 1))
        end
    end

    if y + 1 <= width then
        table.insert(neighbours, life.get_cell(array, x, y + 1))
    end

    if y - 1 <= height then
        table.insert(neighbours, life.get_cell(array, x, y - 1))
    end

    return neighbours
end

return life