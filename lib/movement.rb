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
        break if !column.between?(0, 7) || !row.between?(0, 7) || row_diff.abs > move_distance ||
         column_diff.abs > move_distance || enemy?(board.get_piece(possible_location)) == false
        moves << possible_location
        break if enemy?(board.get_piece(possible_location))
      end
    end
    moves
  end

end