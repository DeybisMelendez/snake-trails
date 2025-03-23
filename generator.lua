local file = io.open("levels.txt", "a")

local game = require "game"
local levels = {}
local seenBoards = {} -- Usamos una tabla hash para verificar duplicados rápidamente
local totalLevels = 0

while totalLevels < 1024 do
    local board = ""
    local randoms = {}
    for _ = 1, 64 do
        board = board .. "."
    end
    for _ = 1, math.random(5, 8) do
        local random
        repeat
            random = math.random(64) -- Generar número aleatorio
        until not randoms[random]    -- Verificar que no haya sido usado antes
        board = board:sub(1, random - 1) .. "#" .. board:sub(random + 1)
        randoms[random] = true       -- Marcar el número como usado
    end

    -- Generar la posición para "O"
    local random
    repeat
        random = math.random(64)
    until not randoms[random]
    board = board:sub(1, random - 1) .. "O" .. board:sub(random + 1)
    randoms[random] = true -- Marcar como usado

    -- Verificar si ya generamos este puzzle
    if not seenBoards[board] then
        game:setBoard(board)
        local result = game:getSolution()

        if result.totalSolutions == 1 and result.totalMoves > 180 then
            print("Found puzzle:")
            game:show()
            print("Moves:", result.totalMoves)
            print("--------")

            -- Guardar el puzzle en la tabla hash y en la lista de niveles
            seenBoards[board] = true
            table.insert(levels, { board, result.totalMoves })
            totalLevels = totalLevels + 1
        end
    end
end

-- Ordenar los niveles por número de movimientos
table.sort(levels, function(a, b)
    return a[2] < b[2]
end)

-- Guardar los niveles ordenados en el archivo
--io.output(file)
for _, level in ipairs(levels) do
    if file == nil then
        break
    end
    file:write(level[1] .. ", " .. level[2] .. "\n")
end

io.close(file)
