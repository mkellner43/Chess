module Movement
  def available_moves
    moves = []
    move_directions.each do |dr, dc|
      row, column = location
      loop do
        current_row, current_column = location
        row += dr
        column += dc
        possible_location = [row, column]
        row_diff = row - current_row
        column_diff = column - current_column
        break if this_move_is_invalid(row, column, row_diff, column_diff, possible_location)

        moves << possible_location
        break if enemy?(board.get_piece(possible_location))
      end
    end
    moves
  end

  def this_move_is_invalid(row, column, row_diff, column_diff, possible_location)
    !column.between?(0, 7) || !row.between?(0, 7) ||
      row_diff.abs > move_distance || column_diff.abs > move_distance ||
      enemy?(board.get_piece(possible_location)) == false
  end

  def wouldnt_put_self_in_check(possible_location)
    board.get_kings
    king = color == :black ? board.black_king : board.white_king
    original_location = location
    move_piece_to_check_validity(location, possible_location)
    result = board.check
    move_piece_to_check_validity(possible_location, original_location)
    return false if result == king

    true
  end

  def move_piece_to_check_validity(previous_loc, possible_location)
    board.set_previous_location(previous_loc, Empty.new)
    board.set_location(possible_location, self)
  end
end
