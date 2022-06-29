require_relative 'piece'
require_relative '../movement'

class Knight < Piece
  include Movement

  def to_s
    color == :black ? "\u265e" : "\u2658"
  end

  def move_directions
    moves = [
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1],
      [-2, 1],
      [1, 2],
      [-1, 2]
    ]
  end

  def move_distance
    2
  end
end
