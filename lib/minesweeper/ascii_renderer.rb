module Minesweeper
  AsciiRenderer = Data.define(:grid) do
    def render(output = $stdout)
      grid.height.times do |y|
        grid.width.times do |x|
          output.print case cell = grid.cell(Coordinate.new(x, y))
                       when nil then "#"
                       when Board::Mine then "*"
                       else cell.neighbour_mines.zero? ? "_" : cell.neighbour_mines
                       end
        end
        output.puts
      end
    end
  end
end
