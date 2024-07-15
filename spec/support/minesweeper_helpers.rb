require "minesweeper/coordinate"
require "minesweeper/ascii_renderer"

module MinesweeperHelpers
  def coord(x, y)
    Minesweeper::Coordinate.new(x, y)
  end

  def ascii_render(board_or_game)
    renderer = Minesweeper::AsciiRenderer.new(board_or_game)
    string_io = StringIO.new
    renderer.render(string_io)
    string_io.string
  end
end
