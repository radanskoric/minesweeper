require_relative "board"

module Minesweeper
  class Game
    CELL_WITH_NO_ADJACENT_MINES = Board::Empty.new(0)

    def initialize(board)
      @cells = Array.new(board.height * board.width)
      @board = board
    end

    def width = @board.width
    def height = @board.height
    def cell(coordinate) = @cells[cell_index(coordinate)]

    def reveal(coordinate)
      index = cell_index(coordinate)
      return :play if @cells[index]

      (@cells[index] = @board.cell(coordinate)).tap do |cell|
        return :lose if cell.is_a?(Board::Mine)
        reveal_neighbours(coordinate) if cell == CELL_WITH_NO_ADJACENT_MINES
      end
      @cells.count(&:nil?) == @board.mines.size ? :win : :play
    end

    private

    def cell_index(coordinate)= coordinate.y * @board.width + coordinate.x

    def reveal_neighbours(coordinate)
      coordinate.neighbours(width, height).each { |n| reveal(n) }
    end
  end
end
