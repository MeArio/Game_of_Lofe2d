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
--- returns true if the cell is underpopulated and false otherwise
-- if the cell has less than 2 live neighbours it is underpopulated
-- @param table array for the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return boolean
------------------------------------------------------------------------------------------------------
function life.underpopulation_check(array, x, y)
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


------------------------------------------------------------------------------------------------------
--- returns true if the cell is overpopulated and false otherwise
-- any cell with more than 3 live neighbours is overpopulated
-- @param table array for the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return boolean
------------------------------------------------------------------------------------------------------
function life.overpopulation_check(array, x, y)
    neighbours = life.get_neighbours(array, x, y)
    alive = 0
    for _, state in pairs(neighbours) do
        if state == 1 then
            alive = alive + 1
        end
    end
    if alive > 3 then
        return true
    else
        return false
    end
end


------------------------------------------------------------------------------------------------------
--- returns true if the cell can reproduce
-- any cell with exactly 3 live neighbours can reproduce
-- @param table array for the cell data table
-- @param x x coordinate for cell
-- @param y y coordinate for cell
-- @return boolean
------------------------------------------------------------------------------------------------------
function life.reproduction_check(array, x, y)
    neighbours = life.get_neighbours(array, x, y)
    alive = 0
    for _, state in pairs(neighbours) do
        if state == 1 then
            alive = alive + 1
        end
    end
    if alive == 3 then
        return true
    else
        return false
    end
end

------------------------------------------------------------------------------------------------------
--- steps trough a generation and returns the next one as a table
-- checks the rules for every pixel then applies them and at the end returns a new table
-- @param table current generation
-- @return table next generation
function life.step_a_generation(game_table)
    next_gen = life.generate_2darray(#game_table, #game_table[1])
    for y=1, #game_table do
        for x=1, #game_table[1] do
            alive = life.get_cell(game_table, x, y)
            if alive == 1 then
                if life.underpopulation_check(game_table, x, y) then
                    life.set_cell(next_gen, x, y, 0)
                elseif life.overpopulation_check(game_table, x, y) then
                    life.set_cell(next_gen, x, y, 0)
                else
                    life.set_cell(next_gen, x, y, 1)
                end
            elseif alive == 0 then
                if life.reproduction_check(game_table, x, y) then
                    life.set_cell(next_gen, x, y, 1)
                end
            end
        end
    end
    return next_gen
end

------------------------------------------------------------------------------------------------------
--- clones a lua 2d array table since they are passed by refference
-- @param table 2d array to be copied
-- @return cloned 2d array
function life.clone_game_table(game_table)
    height = #game_table
    width = #game_table[1]
    clone_table = life.generate_2darray(width, height)
    for x=1, width do
        for y=1, height do
            if life.get_cell(game_table, x, y) == 1 then
                life.set_cell(clone_table, x, y, 1)
            end
        end
    end
    return clone_table
end

return life