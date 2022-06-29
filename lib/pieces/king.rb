require_relative 'piece'
require_relative '../movement'

class King < Piece
  include Movement

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
      [-1, -1],
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
    return unless rooks.length > 1
    return unless wants_to_castle?
    return unless selected_rook = valid_rook(rooks)

    rook_location, king_location = make_castling_move(selected_rook)
    board.move_piece([selected_rook, rook_location])
    board.move_piece([self, king_location])
    true
  end

  def make_castling_move(rook)
    movement_direction = find_difference(rook)
    rook_row, rook_column = rook.location
    row, column = location
    column += (movement_direction * -2)
    rook_column = column + movement_direction
    [[rook_row, rook_column], [row, column]]
  end

  def valid_rook(rooks)
    puts 'select an available rook for this move'
    loop do
      input = gets.chomp.downcase.chars
      input == 'cancel'.chars ? return : selected = board.exchange(input)

      loc, piece = selected
      rooks.each { |rook| return piece if rook == piece }
      puts "select a rook that is in the original location and there are no pieces\nbetween it and your king. If you would like to cancel castling type cancel."
    end
  end

  def wants_to_castle?
    puts 'castling move is available would you like to use it? (y/n)'
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
        if position.is_a?(Rook) && !enemy?(position) && position.original_location? && original_location?
          rooks << position
        end
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
