require_relative 'lib/game'
include SaveFile
include Message

def game_type
  loop do
    puts text(:load_or_new)
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
    puts text(:replay)
    input = gets.chomp
    return game_type if %w[y n].include?(input)
  end
end

game_type
