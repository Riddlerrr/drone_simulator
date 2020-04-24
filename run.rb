$LOAD_PATH << File.join(__dir__, "lib")
require "drone"

DroneCommands.run_all_from_file(ARGV[0] || "commands.txt")
