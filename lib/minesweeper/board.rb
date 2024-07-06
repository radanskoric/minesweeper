require_relative "coordinate"

module Minesweeper
  class Board
    class Mine; end;
    Empty = Data.define(:neighbour_mines)

    attr_accessor :width, :height

    # @param width [Integer]
    # @param height [Integer]
    # @param mines [Array<Coordinate>] locations of mines
    def initialize(width, height, mines)
      @width = width
      @height = height
      @mines = mines
    end

    def cell(coordinate)
      @mines.include?(coordinate) ? Mine.new : Empty.new(count_neighbours(coordinate))
    end

    private

    def count_neighbours(coordinate)
      @mines.count { |mine| mine.neighbour?(coordinate) }
    end
  end
end
