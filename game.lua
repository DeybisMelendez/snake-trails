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
    local pos = 1
    self.board = board
    self.pos = board:find("O")
    print(self.board)
    print(self.pos)
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
    if x < 8 and self.board:sub(self.pos + 1, self.pos + 1) == "." then
        table.insert(moves, game.RIGHT)
    end
    if y > 0 and self.board:sub(self.pos - 8, self.pos - 8) == "." then
        table.insert(moves, game.UP)
    end
    if y < 8 and self.board:sub(self.pos + 8, self.pos + 8) == "." then
        table.insert(moves, game.DOWN)
    end
    return moves
end

function game:goLeft()
    local pos = self.pos
    local x, y = self.getXY(pos)
    while x >= 0 do
        if self.board:sub(pos, pos) == "#" then
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
    while x < 7 do
        if self.board:sub(pos, pos) == "#" then
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
        if self.board:sub(pos, pos) == "#" then
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
        if self.board:sub(pos, pos) == "#" then
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
    for y = 1, 8 do
        for x = 1, 8 do
            io.write(self.board:sub(x + y * 8, x + y * 8))
        end
        io.write("\n")
    end
end

return game
