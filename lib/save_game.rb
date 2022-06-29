require 'yaml'
require_relative 'game'

module SaveFile
  include Message
  def save_this_game
    puts text(:save)
    file_name = gets.chomp.to_s
    valid_file_name?(file_name)
    Dir.mkdir('saved_games') unless File.exist?('saved_games')
    File.open("saved_games/#{file_name}.yaml", 'w') { |f| f.write save_to_yaml }
    puts text(:saved)
    exit
  end

  def load_this_game
    puts text(:choose_file)
    file_list
    puts text(:saved_name)
    file_name = gets.chomp.to_s
    begin
      loaded_game = YAML.unsafe_load(File.read("saved_games/#{file_name}.yaml"))
    rescue Errno::ENOENT
      puts text(:no_file)
      return load_this_game
    end
    puts text(:game_loaded)
    loaded_game.player_turns
  end

  def file_list
    files = []
    names = []
    Dir.entries('saved_games').each { |name| files << name }
    files.each do |file|
      names.push(file.split('.')[0])
    end
    puts names
  end

  def valid_file_name?(file_name)
    File.exist?(file_name) ? save_this_game : false
  end

  def save_to_yaml
    YAML.dump(self)
  end
end
