class Piece
  attr_reader :board
  attr_accessor :location, :previous_location, :color

  def initialize(board, location, color, previous_location)
    @color = color
    @board = board
    @location = location
    @previous_location = previous_location
  end

  def enemy?(piece)
    return unless piece.is_a?(Piece)

    !(piece.color == color)
  end

  def original_location?
    location == previous_location
  end
end
