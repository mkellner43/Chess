require_relative 'pieces_require'

class Game
  include SaveFile
  attr_reader :board, :display_board, :player1, :player2, :game

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

  def save_or_load(input)
    return save_this_game if input.downcase == 'save'
    return load_this_game if input.downcase == 'load'
    return exit if input.downcase == 'exit'
  end

  def send_game(game)
    @game = game
  end

  def create_players
    (1..2).each do |n|
      puts text(:your_name, n)
      player = instance_variable_get("@player#{n}")
      player.name = player.valid_name?(gets.chomp)
    end
  end

  def player_turns
    loop do
      player_move(player1) if whose_turn == player1
      incriment(player1)
      return puts text(:won, player1.name) if win?

      player_move(player2) if whose_turn == player2
      incriment(player2)
      return puts text(:won, player2.name) if win?
    end
  end

  def whose_turn
    player1.turns > player2.turns ? (return player2) : (return player1)
    player1
  end

  def player_move(player)
    display_board.render
    puts text(:select_piece, player.name)
    selected_piece, move_to = player_input(player)
    selected_piece.castling if selected_piece.respond_to?(:castling) && selected_piece.castling
    board.move_piece([selected_piece, move_to])
  end

  def incriment(player)
    board.turn += 1
    player.turns += 1
  end

  def player_input(player)
    loop do
      selected_piece = board.valid_piece(gets.chomp)
      return save_or_load(selected_piece) if selected_piece.is_a?(String)

      puts text(:select_move) if selected_piece
      if selected_piece.is_a?(Piece) && selected_piece.color == player.color
        move_to = board.valid_move(gets.chomp,
                                   selected_piece)
      end
      return save_or_load(move_to) if move_to.is_a?(String)
      return [selected_piece, move_to] if move_to

      display_board.render
      puts text(:invalid_move)
    end
  end

  def win?
    board.get_kings
    return true if board.checkmate

    checked_piece = board.check
    puts text(:in_check, checked_piece) if checked_piece
  end
end
