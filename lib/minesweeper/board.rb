require_relative "coordinate"

module Minesweeper
  class Board < Data.define(:width, :height, :mines)
    class Mine; end;
    Empty = Data.define(:neighbour_mines)

    def self.generate_random(width, height, mines_count)
      full_board = Enumerator::Product.new(width.times, height.times).map { |x, y| Coordinate.new(x, y) }
      self.new(width, height, full_board.sample(mines_count))
    end

    def cell(coordinate)
      mines.include?(coordinate) ? Mine.new : Empty.new(count_neighbours(coordinate))
    end

    private

    def count_neighbours(coordinate)
      mines.count { |mine| mine.neighbour?(coordinate) }
    end
  end
end
