local game = {
    board = {},
    LEFT = 0,
    RIGHT = 1,
    UP = 2,
    DOWN = 3
}

function game.__replaceAt(str, index, new_char)
    return str:sub(1, index - 1) .. new_char .. str:sub(index + 1)
end

function game:setBoard(board)
    self.board = board
    self.pos = board:find("O")
end

function game:getSolution()
    local actualBoard = self.board
    local actualPos = self.pos

    local moves = self:getMoves()
    local totalSolutions = 0
    local totalMoves = #moves

    for _, move in ipairs(moves) do
        -- Realizar movimiento
        if move == self.UP then
            self:goUp()
        elseif move == self.DOWN then
            self:goDown()
        elseif move == self.LEFT then
            self:goLeft()
        elseif move == self.RIGHT then
            self:goRight()
        end
        local results = self:getSolution()
        totalMoves = totalMoves + results.totalMoves
        totalSolutions = totalSolutions + results.totalSolutions

        -- Restaurar estado original
        self.board = actualBoard
        self.pos = actualPos
    end

    if self.board:find("%.") == nil then
        totalSolutions = totalSolutions + 1
    end
    return { totalSolutions = totalSolutions, totalMoves = totalMoves }
end

function game.getXY(pos)
    local y = math.floor((pos - 1) / 8)
    local x = pos - 1 - y * 8
    return x, y
end

function game:getMoves()
    local moves = {}
    local x, y = self.getXY(self.pos)
    if x > 0 and self.board:sub(self.pos - 1, self.pos - 1) == "." then
        table.insert(moves, game.LEFT)
    end
    if x < 7 and self.board:sub(self.pos + 1, self.pos + 1) == "." then
        table.insert(moves, game.RIGHT)
    end
    if y > 1 and self.board:sub(self.pos - 8, self.pos - 8) == "." then
        table.insert(moves, game.UP)
    end
    if y < 7 and self.board:sub(self.pos + 8, self.pos + 8) == "." then
        table.insert(moves, game.DOWN)
    end
    return moves
end

function game:goLeft()
    local pos = self.pos
    local x, y = self.getXY(pos)
    while x >= 0 do
        if self.board:sub(pos, pos) == "#" or self.board:sub(pos, pos) == "T" then
            break
        end
        self.board = self.__replaceAt(self.board, pos, "T")
        x = x - 1
        pos = pos - 1
    end
    pos = pos + 1
    self.board = self.__replaceAt(self.board, pos, "O")
    self.pos = pos
end

function game:goRight()
    local pos = self.pos
    local x, y = self.getXY(pos)
    while x < 8 do
        if self.board:sub(pos, pos) == "#" or self.board:sub(pos, pos) == "T" then
            break
        end
        self.board = self.__replaceAt(self.board, pos, "T")
        x = x + 1
        pos = pos + 1
    end
    pos = pos - 1
    self.board = self.__replaceAt(self.board, pos, "O")
    self.pos = pos
end

function game:goUp()
    local pos = self.pos
    local x, y = self.getXY(pos)
    while y >= 0 do
        if self.board:sub(pos, pos) == "#" or self.board:sub(pos, pos) == "T" then
            break
        end
        self.board = self.__replaceAt(self.board, pos, "T")
        y = y - 1
        pos = pos - 8
    end
    pos = pos + 8
    self.board = self.__replaceAt(self.board, pos, "O")
    self.pos = pos
end

function game:goDown()
    local pos = self.pos
    local x, y = self.getXY(pos)
    while y < 8 do
        if self.board:sub(pos, pos) == "#" or self.board:sub(pos, pos) == "T" then
            break
        end
        self.board = self.__replaceAt(self.board, pos, "T")
        y = y + 1
        pos = pos + 8
    end
    pos = pos - 8
    self.board = self.__replaceAt(self.board, pos, "O")
    self.pos = pos
end

function game:show()
    for y = 0, 7 do
        for x = 1, 8 do
            io.write(self.board:sub(x + y * 8, x + y * 8))
        end
        io.write("\n")
    end
end

return game
