defmodule RobotSimulator do
  alias RobotSimulator.InputHandler
  defstruct [:direction, :position]

  @valid_directions ~w"north east south west"a

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any

  def create() do
    %RobotSimulator{direction: :north, position: {0, 0}}
  end

  def create(direction, _) when direction not in @valid_directions do
    {:error, "invalid direction"}
  end

  def create(_, position) when not is_tuple(position) do
    {:error, "invalid position"}
  end

  def create(_, position) when tuple_size(position) !== 2 do
    {:error, "invalid position"}
  end

  def create(_, {x, y}) when not is_integer(x) or not is_integer(y) do
    {:error, "invalid position"}
  end

  def create(direction, position) do
    %RobotSimulator{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions_array = String.codepoints(instructions)

    robot
    |> InputHandler.handle_input(instructions_array)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
