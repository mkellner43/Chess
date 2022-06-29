require_relative 'piece'
require_relative '../movement'

class Rook < Piece
  include  Movement

  def to_s
    color == :black ? "\u265c" : "\u2656"
  end

  def move_directions
    moves = [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end

  def move_distance
    7
  end
end
