class BoardRender
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def render
    puts "\n"
    row = 8
    board.grid.each do |r|
      print "#{row}  "
      puts r.join(' | ')
      puts '  -------------------------------' unless row == 1
      row -= 1
    end
    puts "\n"
    print '   '
    puts ('a'..'h').to_a.join('   ')
    puts "\n"
  end
end
