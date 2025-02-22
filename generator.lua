local file = io.open("levels.txt", "a")

local game = require "game"
game:setBoard(".....#.......#.................................................O")
print(game.getXY(game.pos))
local moves = game:getMoves()
for i = 1, #moves do
    print(moves[i])
end
game:show()
game:goUp()
game:show()
game:goRight()
game:show()
game:goDown()
game:show()
game:goLeft()
game:show()
game:goUp()
game:show()

game:goRight()
game:show()

game:goDown()

game:show()
-- io.output(file)
io.close(file)
