require_relative 'piece'
require_relative '../movement'

class Bishop < Piece
  include Movement

  def to_s
    color == :black ? "\u265d" : "\u2657"
  end

  def move_directions
    moves = [
      [1, 1],
      [-1, 1],
      [-1, -1],
      [1, -1]
    ]
  end

  def move_distance
    7
  end
end
