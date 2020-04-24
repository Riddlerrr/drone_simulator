RC Drone Simulator
===================

Description
-----------

- The program is an RC drone simulator.
- Drone is moving in a room of dimensions 5x5x5 units.
- Room is empty, hence there are no obstacles except the walls, floor and ceiling.
- Drone can roam around the room, but must be prevented from hitting it's boundaries. Any movement that would result in the drone hitting the boundaries must be prevented, however further valid movement commands must still be allowed.

Create a program that takes commands of the following (textual) form as an input:

    SPAWN X,Y,Z,F
    MOVE
    LEFT
    RIGHT
    UP
    DOWN
    REPORT

- SPAWN will put the drone in the room in position X,Y,Z and facing NORTH,
  SOUTH, EAST or WEST.
- The origin (0,0,0) can be considered to be the SOUTH WEST bottom corner.
- The first valid command to the drone is a SPAWN command, after that, any
  sequence of commands may be issued, in any order, including another SPAWN
  command. The application should discard all commands in the sequence until
  a valid SPAWN command has been executed.
- MOVE will move the drone one unit forward in the direction it is
  currently facing.
- LEFT and RIGHT will rotate the drone 90 degrees in the specified direction
  without changing the position of the drone.
- UP will move the drone up (along positive direction of Z-axis).
- DOWN will move the drone down (along negative direction of Z-axis).
- REPORT will print out the X,Y,Z and F of the drone. This can be in any form,
  but standard output is sufficient.

- A drone that is not on the table can choose to ignore the MOVE, LEFT, RIGHT, UP, DOWN
  and REPORT commands.
- Input can be from a file, or from standard input, as the developer chooses.
- Provide test data to exercise the application.
- The application must be a command line application.

Constraints
-----------

- Drone must not hit the boundaries of the room during movement. This also
  includes the initial placement of the drone.
- Drone can only face NORTH, SOUTH, EAST, WEST.
- Any move that would cause the drone to hit the walls, floor or ceiling must be ignored.

Example Input and Output
------------------------

### Example a

    SPAWN 0,0,0,NORTH
    MOVE
    REPORT

Expected output:

    0,1,0,NORTH

### Example b

    SPAWN 0,0,0,NORTH
    LEFT
    REPORT

Expected output:

    0,0,0,WEST

### Example c

    SPAWN 1,2,0,EAST
    MOVE
    MOVE
    UP
    LEFT
    MOVE
    UP
    REPORT

Expected output

    3,3,2,NORTH

### Example d

    SPAWN 1,1,1,NORTH
    DOWN
    MOVE
    DOWN
    REPORT

Expected output

    1,2,0,NORTH

Deliverables
------------

Please provide your source code, and any test code/data you using in
developing your solution.

Please engineer your solution to a standard you consider suitable for
production. It is not required to provide any graphical output showing the
movement of the drone.
