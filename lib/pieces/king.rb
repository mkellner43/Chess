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
    usable_rooks = get_rooks_castling
    return unless usable_rooks.length > 0
    rooks = []
    usable_rooks.each { |rook| rooks << rook if row_available_castling(rook) }
    rooks 
    # return unless wants_to_castle?
    # puts "select an available rook for this movement"
    # input = gets.chomp
  end

  def wants_to_castle?
    puts "castling move is available would you like to use it? (y/n)"
    loop do
      input = gets.chomp
      return true if input == 'y'
      return false if input == 'n'
      puts 'please type y or n'
    end
  end

  def get_rooks_castling
    rooks = []
    board.grid.each do |row|
      row.each do |position|
        rooks << position if position.is_a?(Rook) && !enemy?(position) && position.original_location? && original_location?
      end
    end
    rooks
  end

  def row_available_castling(rook)
    rook_row, rook_column = rook.location
    row, column = location 
    move_column = find_difference(rook)
    loop do 
      rook_column += move_column
      break if rook_column == column
      rook_column += move_column
      return if board.get_piece([rook_row, rook_column]).is_a?(Piece)
    end
    true
  end

  def find_difference(rook)
    rook_row, rook_column = rook.location
    row, column = location
    rook_column > column ? -1 : 1
  end


end