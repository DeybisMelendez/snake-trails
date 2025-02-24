local file = io.open("levels.txt", "a")

local game = require "game"

game:setBoard("...............................................................O")
local result = game:getSolution()
print(result.totalSolutions, result.totalMoves)
--game:goUp()
--game:show()
--print(game:getMoves()[1], game:getMoves()[2])
-- io.output(file)
io.close(file)
