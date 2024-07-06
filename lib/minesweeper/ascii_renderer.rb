module Minesweeper
  class AsciiRenderer
    def initialize(board)
      @board = board
    end

    def render(output = $stdout)
      @board.height.times do |y|
        @board.width.times do |x|
          cell = @board.cell(Coordinate.new(x, y))
          if cell.is_a?(Board::Mine)
            output.print "*"
          elsif cell.is_a?(Board::Empty)
            output.print (cell.neighbour_mines.zero? ? "_" : cell.neighbour_mines)
          end
        end
        output.puts
      end
    end
  end
end
