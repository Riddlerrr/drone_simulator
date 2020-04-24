class Drone
  ROOM_LENGTH_X = 5
  ROOM_LENGTH_Y = 5
  ROOM_LENGTH_Z = 5

  DIRECTIONS = %i[north east south west]

  attr_reader :x, :y, :z
  attr_accessor :direction

  def initialize(init_x, init_y, init_z, direction)
    raise ArgumentError, "Invalid direction" unless DIRECTIONS.include?(direction)

    self.x = init_x
    self.y = init_y
    self.z = init_z
    @direction = direction

    if [x, y, z].any?(&:nil?)
      raise ArgumentError, "Invalid coordinates"
    end
  end

  def move
    case direction
    when :north then self.y += 1
    when :east then self.x += 1
    when :south then self.y -= 1
    when :west then self.x -= 1
    end
  end

  def turn_right
    self.direction = turn(:right)
  end

  def turn_left
    self.direction = turn(:left)
  end

  def up
    self.z += 1
  end

  def down
    self.z -= 1
  end

  def report
    "#{x},#{y},#{z},#{direction.to_s.upcase}"
  end

  private

  def x=(new_coordinate)
    return unless safe_move?(new_coordinate, ROOM_LENGTH_X)

    @x = new_coordinate
  end

  def y=(new_coordinate)
    return unless safe_move?(new_coordinate, ROOM_LENGTH_Y)

    @y = new_coordinate
  end

  def z=(new_coordinate)
    return unless safe_move?(new_coordinate, ROOM_LENGTH_Z)

    @z = new_coordinate
  end

  def turn(turn_direction)
    current_index = DIRECTIONS.index(direction)
    next_index =
      if turn_direction == :right
        (current_index + 1) % 4
      else
        current_index - 1
      end
    DIRECTIONS[next_index]
  end

  def safe_move?(coordinate, max_coordinate)
    coordinate.between?(0, max_coordinate)
  end
end
