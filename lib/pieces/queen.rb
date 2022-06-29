require_relative 'piece'
require_relative '../movement'

class Queen < Piece
  include Movement

  def to_s
    color == :black ? "\u265b" : "\u2655"
  end

  def move_directions
    moves = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end

  def move_distance
    7
  end
end
