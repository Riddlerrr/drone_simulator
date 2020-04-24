require_relative "drone"

class DroneCommands
  attr_reader :drone

  def self.run_all_from_string(commands_string)
    new(commands_string.split("\n"))
  end

  def self.run_all_from_file(file_name)
    run_all_from_string(File.read(file_name))
  end

  def initialize(commands = [])
    commands.each do |command|
      run(command)
    end
  end

  def run(command)
    command, attrs = command.downcase.split(/\s+/)
    command = command.to_sym
    return spawn(attrs) if command == :spawn
    return unless drone

    case command
    when :left then drone.turn_left
    when :right then drone.turn_right
    when :report then print_report
    else drone.public_send(command)
    end
  rescue NoMethodError
    nil # Just ignore wrong commands
  end

  private

  def spawn(command_string)
    x, y, z, direction = command_string.split(",")
    @drone = Drone.new(x.to_i, y.to_i, z.to_i, direction.downcase.to_sym)
  end

  def print_report
    puts drone.report
  end
end
