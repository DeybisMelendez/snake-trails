local game = require "game"
local level = "..............................O...#.........#....#.........#...."

game:setBoard(level)

while true do
    os.execute("clear")
    game:show()
    local action = io.read("n")
    if action == 4 then
        game:goLeft()
    elseif action == 6 then
        game:goRight()
    elseif action == 8 then
        game:goUp()
    elseif action == 2 then
        game:goDown()
    end
end
