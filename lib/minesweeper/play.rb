require "readline"

require_relative "lib/minesweeper/ascii_renderer"
require_relative "lib/minesweeper/game"

module Minesweeper
  module_function def play(...)
    game = Game.new(Board.generate_random(...))
    renderer = AsciiRenderer.new(game)
    renderer.render

    while input = Readline.readline("Type click coordinate as 'x, y' (0 based)> ")
      result = game.reveal(Coordinate.new(*input.split(",").map(&:to_i)))
      renderer.render
      if [:win, :lose].include?(result)
        puts "You #{result == :win ? "win" : "lose"}!"
        return
      end
    end
  end
end

if ARGV.size == 3
  Minesweeper.play(*ARGV.map(&:to_i))
else
  puts "Usage: ruby lib/play.rb width, height, mines_count (e.g. 'play.rb 12 6 6')"
end
