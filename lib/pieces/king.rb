require_relative 'piece'
require_relative '../movement'

class King < Piece
  include Movement
  attr_accessor :castled

  def has_castled
    @castled = false
  end
  
  def to_s
    color == :black ? "\u265a" : "\u2654"
  end

  def move_directions
    moves = [
      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1 , -1],
      [0, -1],
      [1, -1]
    ]
  end

  def move_distance
    1
  end

  def castling
    rook_one, rook_two = get_rooks
    
  end

end