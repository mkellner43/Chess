require_relative 'lib/game'
include SaveFile

def game_type
  loop do
  puts 'would you like to load a game or start a new game?'
  puts "type 'load' to load and 'new' to start a new game"
  input = gets.chomp
  return new_game if input.downcase == 'new'
  return load_this_game if input.downcase == 'load'
  end
end

def new_game
  game = Game.new
  game.send_game(game)
  game.create_board
  game.create_players
  game.player_turns
  replay?
end

def replay?
  loop do
  puts 'would you like to play again? (y/n)'
  input = gets.chomp
  return game_type if input == 'y' || input == 'n'
  end
end

game_type