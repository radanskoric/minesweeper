module Minesweeper
  Coordinate = Data.define(:x, :y) do
    def neighbour?(other)
      [(self.x - other.x).abs, (self.y - other.y).abs].max <= 1
    end
  end
end
