require "drone/drone"
require "drone/drone_commands"

RSpec.describe DroneCommands do
  let(:sample_commands) do
    <<~COMMANDS
      SPAWN 0,0,0,NORTH
      MOVE
      REPORT
    COMMANDS
  end

  describe ".run_all_from_string" do
    it "successfully runs all commands" do
      expect { described_class.run_all_from_string(sample_commands) }.to output("0,1,0,NORTH\n").to_stdout
    end
  end

  describe ".run_all_from_file" do
    it "successfully runs all commands" do
      File.write("test_commands.txt", sample_commands)
      expect { described_class.run_all_from_file("test_commands.txt") }.to output("0,1,0,NORTH\n").to_stdout
      File.delete("test_commands.txt")
    end
  end

  describe "#initialize" do
    it "successfully runs all commands" do
      expect { described_class.new(["SPAWN 0,0,0,NORTH", "MOVE", "REPORT"]) }.to output("0,1,0,NORTH\n").to_stdout
    end

    it "don't print anything when drone don't spawned" do
      expect { described_class.new(%w[MOVE REPORT]) }.to output("").to_stdout
    end

    it "works with double spawn" do
      commands = ["SPAWN 0,0,0,NORTH", "MOVE", "REPORT"] * 2
      expect { described_class.new(commands) }.to output("0,1,0,NORTH\n0,1,0,NORTH\n").to_stdout
    end
  end

  describe "#run" do
    let(:drone_commands) { described_class.new(["SPAWN 1,1,1,NORTH"]) }
    let(:drone) { drone_commands.drone }

    it "correct command" do
      expect(drone.report).to eq "1,1,1,NORTH"
      drone_commands.run("LEFT")
      expect(drone.report).to eq "1,1,1,WEST"
      drone_commands.run("MOVE")
      expect(drone.report).to eq "0,1,1,WEST"
      drone_commands.run("UP")
      expect(drone.report).to eq "0,1,2,WEST"
      drone_commands.run("RIGHT")
      expect(drone.report).to eq "0,1,2,NORTH"
      drone_commands.run("DOWN")
      expect(drone.report).to eq "0,1,1,NORTH"
    end
  end
end
