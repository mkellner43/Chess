require_relative 'lib/pieces_require'

class Game
  attr_reader :board, :display_board, :player1, :player2

  def initialize
    @board = Board.new
    @display_board = BoardRender.new(board)
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
  end

  def create_board
    8.times do |n|
      board.set_location([1, n], Pawn.new(board, [1, n], :black, [1, n]))
      board.set_location([6, n], Pawn.new(board, [6, n], :white, [6, n]))
    end
    [0, 7].each do |n|
      board.set_location([0, n], Rook.new(board, [0, n], :black, [0, n]))
      board.set_location([7, n], Rook.new(board, [7, n], :white, [7, n]))
    end
    [1, 6].each do |n|
      board.set_location([0, n], Knight.new(board, [0, n], :black, [0, n]))
      board.set_location([7, n], Knight.new(board, [7, n], :white, [7, n]))
    end
    [2, 5].each do |n|
      board.set_location([0, n], Bishop.new(board, [0, n], :black, [0, n]))
      board.set_location([7, n], Bishop.new(board, [7, n], :white, [7, n]))
    end
      board.set_location([0, 3], Queen.new(board, [0, 3], :black, [0, 3]))
      board.set_location([7, 4], Queen.new(board, [7, 4], :white, [7, 4]))
      board.set_location([0, 4], King.new(board, [0, 4], :black, [0, 4]))
      board.set_location([7, 3], King.new(board, [7, 3], :white, [7, 3]))

      display_board.render
  end

  def create_players
    (1..2).each do |n|
      puts "Player #{n}, what is your name?"
      player = instance_variable_get("@player#{n}")
      player.name = player.valid_name?(gets.chomp)
    end
  end

  def player_turns
    loop do
      player_move(player1)
      return puts "#{player1.name} wins!" if win?
      player_move(player2)
      return puts "#{player2.name} wins!" if win?
    end
  end


  def player_move(player)
    board.turn += 1
    display_board.render
    puts "#{player.name} select your piece"
    selected_piece, move_to = player_input(player)
    selected_piece.castling if selected_piece.respond_to?(:castling) && selected_piece.castling
    board.move_piece([selected_piece, move_to])
  end

  def player_input(player)
    loop do
      selected_piece = board.valid_piece(gets.chomp.chars)
      puts "#{player.name} select your move" if selected_piece
      selected_piece.is_a?(Piece) && selected_piece.color == player.color ? move_to = board.valid_move(gets.chomp.chars, selected_piece) : nil
      return [selected_piece, move_to] if move_to
      
      display_board.render
      puts 'Invalid move, select your piece'
    end
  end

  def win?
    board.get_kings
    return true if board.checkmate
    checked_piece = board.check
    puts "#{checked_piece} is now in check! Be careful with your next move" if checked_piece
  end

end