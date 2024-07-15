module Minesweeper
  Coordinate = Data.define(:x, :y) do
    NEIGHBOURS = (Enumerator.product([-1, 0, 1], [-1, 0, 1]).to_a - [0, 0]).map { |x, y| self.new(x, y) }

    def neighbour?(other)
      [(self.x - other.x).abs, (self.y - other.y).abs].max <= 1
    end

    def +(other)
      self.class.new(self.x + other.x, self.y + other.y)
    end

    def neighbours(board_width, board_height)
      NEIGHBOURS
        .map { |n| self + n }
        .reject { |n| n.x < 0 || n.x >= board_width || n.y < 0 || n.y >= board_height }
    end
  end
end
