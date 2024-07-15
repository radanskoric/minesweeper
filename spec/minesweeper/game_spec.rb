require "spec_helper"

require "minesweeper/game"
require "minesweeper/board"

RSpec.describe Minesweeper::Game do
  let(:mines) { [coord(1, 0), coord(3, 1), coord(3, 2), coord(5,1), coord(5,2)] }
  let(:board) { Minesweeper::Board.new(8, 3, mines) }
  let(:game) { described_class.new(board) }

  it "allows to play a game and win" do
    expect(ascii_render(game)).to eq <<~BOARD
      ########
      ########
      ########
    BOARD

    expect(game.reveal(coord(0, 1))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      ########
      1#######
      ########
    BOARD

    expect(game.reveal(coord(2, 1))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      ########
      1#3#####
      ########
    BOARD

    expect(game.reveal(coord(7, 0))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      ######1_
      1#3###2_
      ######2_
    BOARD

    expect(game.reveal(coord(0, 2))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      ######1_
      113###2_
      __2###2_
    BOARD

    game.reveal(coord(0, 0))
    game.reveal(coord(2, 0))
    game.reveal(coord(3, 0))
    game.reveal(coord(4, 0))
    game.reveal(coord(5, 0))
    expect(game.reveal(coord(4, 1))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      1#21211_
      113#4#2_
      __2###2_
    BOARD

    expect(game.reveal(coord(4, 2))).to eq :win
    expect(ascii_render(game)).to eq <<~BOARD
      1#21211_
      113#4#2_
      __2#4#2_
    BOARD
  end

  it "allows to play a game and win" do
    expect(game.reveal(coord(0, 1))).to eq :play
    expect(ascii_render(game)).to eq <<~BOARD
      ########
      1#######
      ########
    BOARD

    expect(game.reveal(coord(1, 0))).to eq :lose
    expect(ascii_render(game)).to eq <<~BOARD
      #*######
      1#######
      ########
    BOARD
  end
end
