require "spec_helper"

RSpec.describe Minesweeper::Coordinate do
  describe "#neighbour?" do
    it "returns true when coordinate just to the right" do
      expect(coord(2, 2).neighbour?(coord(3, 2))).to be true
    end

    it "returns true when coordinate below" do
      expect(coord(2, 2).neighbour?(coord(2, 3))).to be true
    end

    it "returns true when coordinate at corner" do
      expect(coord(2, 2).neighbour?(coord(1, 1))).to be true
    end

    it "returns false when coordinate two to the right" do
      expect(coord(2, 2).neighbour?(coord(4, 2))).to be false
    end

    it "returns false when coordinate two below" do
      expect(coord(2, 2).neighbour?(coord(2, 4))).to be false
    end

    it "returns false when coordinate diagonally 2 away" do
      expect(coord(2, 2).neighbour?(coord(0, 0))).to be false
    end
  end
end
