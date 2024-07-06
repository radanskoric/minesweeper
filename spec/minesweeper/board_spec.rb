require "spec_helper"

require "minesweeper/board"
require "minesweeper/ascii_renderer"

RSpec.describe Minesweeper::Board do
  let(:full_3_2_board) { Enumerator::Product.new(0..2, 0..1).map { coord(_1, _2) } }

  def render_for(width, height, mines)
    board = described_class.new(width, height, mines)
    renderer = Minesweeper::AsciiRenderer.new(board)
    string_io = StringIO.new
    renderer.render(string_io)
    string_io.string
  end

  it "calculates correctly when it's all mines" do
    expect(render_for(3, 2, full_3_2_board)).to eq <<~BOARD
      ***
      ***
    BOARD
  end

  it "calculates correctly when it's no mines" do
    expect(render_for(3, 2, [])).to eq <<~BOARD
      ___
      ___
    BOARD
  end

  it "calculates correctly with one mine" do
    expect(render_for(3, 2, [coord(0, 0)])).to eq <<~BOARD
      *1_
      11_
    BOARD
  end

  it "calculates correctly with two mines" do
    expect(render_for(3, 2, [coord(0, 0), coord(2, 0)])).to eq <<~BOARD
      *2*
      121
    BOARD
  end

  it "calculates correctly with just one empty field" do
    expect(render_for(3, 2, full_3_2_board - [coord(1, 1)])).to eq <<~BOARD
      ***
      *5*
    BOARD
  end

  it "calculates correctly with a more complex board" do
    expect(render_for(8, 4, [coord(1, 1), coord(3, 1), coord(3, 2), coord(5,1), coord(5,2), coord(5,3)])).to eq <<~BOARD
      1121211_
      1*3*4*2_
      113*5*3_
      __113*2_
    BOARD
  end
end
