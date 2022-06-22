class Board
  attr_reader :grid, :letters, :numbers
  attr_accessor :en_passant_location, :en_passant_turn, :turn, :en_passant_piece

  def initialize
    @grid = Array.new(8) { Array.new(8, Empty.new) }
    @letters = {'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7}
    @numbers = {'1' => 7, '2' => 6, '3' => 5, '4' => 4, '5' => 3, '6' => 2, '7' => 1, '8' => 0}
    @en_passant_turn = nil
    @en_passant_location = nil
    @en_passant_piece = nil
    @turn = 1
  end

  def set_location(loc, piece)
    row, column = loc
    grid[row][column] = piece
    piece.location = loc
  end
  
  def set_previous_location(loc, piece)
    previous_loc = loc
    set_location(previous_loc, piece)
  end

  def get_piece(loc)
    row, column = loc
    grid[row][column]
  end

  def valid_piece(input)
    location, piece = exchange(input)
    return unless piece.is_a?(Piece)
    piece if piece.location.all? { |value| value.between?(0, 7) }
  end

  def valid_move(move_to, piece)
    move_to_location, object = exchange(move_to)
    return unless object.is_a?(Empty) || piece.enemy?(object)
    piece.en_passant(move_to_location) if piece.respond_to?(:en_passant)
    move_to_location if piece.available_moves.any? { |move| move == move_to_location }
  end

  def exchange(input)
    return unless ('1'..'8').include?(input[0]) && ('a'..'h').include?(input[1]) && input.length == 2
    input = [numbers[input.first], letters[input.last.downcase]]
    object = get_piece(input)
    [input, object]
  end

  def move_piece(input)
    selected_piece, move_to = input
    set_previous_location(selected_piece.location, Empty.new)
    en_passant_piece.take_en_passant(move_to) if en_passant_location
    set_location(move_to, selected_piece)
    selected_piece.promotion if selected_piece.respond_to?(:promotion)
  end

end