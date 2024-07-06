# Add the lib directory to the load path
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

# Require the top level game files
require 'minesweeper/board'
require 'minesweeper/ascii_renderer'

require "benchmark"

def generate_board!(width, height, mines_count)
  puts "Generating board ..."
  string_io = StringIO.new

  timing = Benchmark.measure do
    full_board = Enumerator::Product.new(width.times, height.times).map { Minesweeper::Coordinate.new(_1, _2) }

    board = Minesweeper::Board.new(
      width,
      height,
      full_board.sample(mines_count)
    )
    Minesweeper::AsciiRenderer.new(board).render(string_io)
  end
  puts "Done, timing:"
  puts timing
  puts "Generated board:"
  puts string_io.string
end
