require "minesweeper/coordinate"

module MinesweeperHelpers
  def coord(x, y)
    Minesweeper::Coordinate.new(x, y)
  end
end
