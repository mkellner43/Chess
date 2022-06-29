require_relative 'piece'
require_relative '../pieces_require'

class Pawn < Piece
  def promote_data
    {
      'queen' => Queen.new(board, nil, nil, nil),
      'king' => King.new(board, nil, nil, nil),
      'bishop' => Bishop.new(board, nil, nil, nil),
      'rook' => Rook.new(board, nil, nil, nil),
      'pawn' => Pawn.new(board, nil, nil, nil),
      'knight' => Knight.new(board, nil, nil, nil)
    }
  end

  def to_s
    color == :black ? "\u265F" : "\u2659"
  end

  def move_distance
    return 2 if location == previous_location

    1
  end

  def forward_direction
    color == :black ? 1 : -1
  end

  def available_moves
    moves = []
    row, column = location

    move_one = [(row + forward_direction), column]
    new_row, new_column = move_one
    moves << move_one if new_row.between?(0, 7) && board.get_piece(move_one).is_a?(Empty)

    move_two = [row + (2 * forward_direction), column]
    new_row, new_column = move_two
    moves << move_two if new_row.between?(0, 7) && board.get_piece(move_two).is_a?(Empty) && move_distance == 2

    take_enemy_one = [(row + forward_direction), (column + 1)]
    take_enemy_two = [(row + forward_direction), (column - 1)]
    new_row, new_colum = take_enemy_one
    new_row_two, new_colum_two = take_enemy_two
    if new_row.between?(0, 7) && new_column.between?(0, 7) && enemy?(board.get_piece(take_enemy_one))
      moves << take_enemy_one
    elsif new_row.between?(0, 7) && new_colum.between?(0, 7) && enemy?(board.get_piece(take_enemy_two))
      moves << take_enemy_two
    end
    moves << board.en_passant_location if en_passant_eligible
    moves
  end

  def en_passant(move_to)
    move_to_row, move_to_column = move_to
    previous_row, previous_column = location
    moved = move_to_row.abs - previous_row.abs
    set_en_passant(previous_row, previous_column) if moved.abs == 2
  end

  def set_en_passant(previous_row, previous_column)
    board.en_passant_piece = self
    board.en_passant_turn = board.turn
    board.en_passant_location = [(previous_row + board.en_passant_piece.forward_direction), previous_column]
  end

  def en_passant_eligible
    return unless board.en_passant_location

    en_row, en_column = board.en_passant_location
    current_row, current_column = location
    moved_row = en_row.abs - current_row.abs
    moved_column = en_column.abs - current_column.abs
    board.en_passant_location && color != board.en_passant_piece.color && moved_row.abs <= move_distance && moved_column.abs <= move_distance
  end

  def take_en_passant(move_to)
    return reset_en_passant unless board.turn - 1 == board.en_passant_turn || board.turn == board.en_passant_turn
    return unless move_to == board.en_passant_location

    board.set_location(board.en_passant_piece.location, Empty.new)
  end

  def reset_en_passant
    board.en_passant_piece = nil
    board.en_passant_turn = nil
    board.en_passant_location = nil
  end

  def promotion
    row, column = location
    color == :black && row == 7 || color == :white && row == 0 ? selection = promote_data[promote_input] : return
    selection.color = color
    selection.previous_location = previous_location
    board.set_location(location, selection)
  end

  def promote_input
    puts 'Congrats, you can promote your pawn to any piece! What would you like to promote to?'
    loop do
      input = gets.chomp
      return input if promote_data.any? { |k, _v| k == input.downcase }
    end
  end

  def wouldnt_put_self_in_check(possible_location)
    board.get_kings
    king = color == :black ? board.black_king : board.white_king
    original_location = location
    move_piece_to_check_validity(location, possible_location)
    result = board.check
    move_piece_to_check_validity(possible_location, location)
    return false if result == king

    true
  end

  def move_piece_to_check_validity(previous_loc, possible_location)
    board.set_previous_location(previous_loc, Empty.new)
    board.set_location(possible_location, self)
  end
end
