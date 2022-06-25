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
      board.turn += 1
      return puts "#{player1} wins!" if win?
      player_move(player2)
      board.turn += 1
      return puts "#{player2} wins!" if win?
    end
  end


  def player_move(player)
    display_board.render
    puts "#{player.name} select your piece"
    selected_piece, move_to = player_input(player)
    return selected_piece.castling if castling
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
    return true if board.checkmate
    puts 'You are now in check! Be careful with your next move' if board.check
  end

end

# game = Game.new
# board = BoardRender.new(game.board)
# king = game.board.set_location([0, 4], King.new(game.board, [0, 4], :white, [0, 4]))
# rook = game.board.set_location([0, 0], Rook.new(game.board, [0, 0], :white, [0, 0]))
# rook = game.board.set_location([0, 7], Pawn.new(game.board, [0, 7], :white, [0, 7]))
# board.render
# king_piece = game.board.get_piece([0, 4])
# king_piece.castling
# board.render
# king_w1 = game.board.set_location([3, 3], Pawn.new(game.board, [3, 3], :black, [3, 3]))
# king_w1 = game.board.set_location([3, 2], Pawn.new(game.board, [3, 2], :black, [3, 2]))
# king_w1 = game.board.set_location([3, 1], Pawn.new(game.board, [3, 1], :black, [3, 1]))
# game.create_players
# game.create_board
# game.player_turns
# game.player_move
# game.player_move
# game.player_move
