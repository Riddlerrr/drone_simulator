require "drone/drone"

RSpec.describe Drone do
  describe "#initialize" do
    it "with correct data" do
      drone = described_class.new(1, 2, 3, :north)
      expect(drone.x).to eq 1
      expect(drone.y).to eq 2
      expect(drone.z).to eq 3
      expect(drone.direction).to eq(:north)
    end

    context "with wrong coordinates" do
      it "x less than 0" do
        expect { described_class.new(-1, 2, 3, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end

      it "x more than room" do
        expect { described_class.new(6, 2, 3, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end

      it "y less than 0" do
        expect { described_class.new(1, -2, 3, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end

      it "y more than room" do
        expect { described_class.new(1, 7, 3, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end

      it "z less than 0" do
        expect { described_class.new(1, 2, -3, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end

      it "z more than room" do
        expect { described_class.new(1, 2, 8, :north) }.to raise_error(ArgumentError, "Invalid coordinates")
      end
    end

    it "with wrong direction" do
      expect { described_class.new(1, 2, 8, :wrong) }.to raise_error(ArgumentError, "Invalid direction")
    end
  end

  describe "#move" do
    context "successful move" do
      it "to north" do
        drone = described_class.new(0, 0, 0, :north)
        drone.move
        expect(drone.x).to eq 0
        expect(drone.y).to eq 1
      end

      it "to east" do
        drone = described_class.new(0, 0, 0, :east)
        drone.move
        expect(drone.x).to eq 1
        expect(drone.y).to eq 0
      end

      it "to south" do
        drone = described_class.new(5, 5, 5, :south)
        drone.move
        expect(drone.x).to eq 5
        expect(drone.y).to eq 4
      end

      it "to west" do
        drone = described_class.new(5, 5, 5, :west)
        drone.move
        expect(drone.x).to eq 4
        expect(drone.y).to eq 5
      end
    end

    context "prevent destruction move" do
      it "to north" do
        drone = described_class.new(5, 5, 5, :north)
        drone.move
        expect(drone.x).to eq 5
        expect(drone.y).to eq 5
      end

      it "to east" do
        drone = described_class.new(5, 5, 5, :east)
        drone.move
        expect(drone.x).to eq 5
        expect(drone.y).to eq 5
      end

      it "to south" do
        drone = described_class.new(0, 0, 0, :south)
        drone.move
        expect(drone.x).to eq 0
        expect(drone.y).to eq 0
      end

      it "to west" do
        drone = described_class.new(0, 0, 0, :west)
        drone.move
        expect(drone.x).to eq 0
        expect(drone.y).to eq 0
      end
    end
  end

  describe "#turn_left" do
    it "successful turn" do
      drone = described_class.new(0, 0, 0, :north)

      expect(drone.direction).to eq :north
      drone.turn_left
      expect(drone.direction).to eq :west
      drone.turn_left
      expect(drone.direction).to eq :south
      drone.turn_left
      expect(drone.direction).to eq :east
      drone.turn_left
      expect(drone.direction).to eq :north
    end
  end

  describe "#turn_right" do
    it "successful turn" do
      drone = described_class.new(0, 0, 0, :north)

      expect(drone.direction).to eq :north
      drone.turn_right
      expect(drone.direction).to eq :east
      drone.turn_right
      expect(drone.direction).to eq :south
      drone.turn_right
      expect(drone.direction).to eq :west
      drone.turn_right
      expect(drone.direction).to eq :north
    end
  end

  describe "#up" do
    it "moves up" do
      drone = described_class.new(0, 0, 0, :north)
      expect(drone.z).to eq 0
      drone.up
      expect(drone.z).to eq 1
    end

    it "prevent destruction move" do
      drone = described_class.new(0, 0, 5, :north)
      expect(drone.z).to eq 5
      drone.up
      expect(drone.z).to eq 5
    end
  end

  describe "#down" do
    it "moves down" do
      drone = described_class.new(5, 5, 5, :north)
      expect(drone.z).to eq 5
      drone.down
      expect(drone.z).to eq 4
    end

    it "prevent destruction move" do
      drone = described_class.new(0, 0, 0, :north)
      expect(drone.z).to eq 0
      drone.down
      expect(drone.z).to eq 0
    end
  end

  describe "#report" do
    let(:drone) { described_class.new(0, 0, 0, :north) }

    it "works" do
      expect(drone.report).to eq "0,0,0,NORTH"
    end
  end
end
