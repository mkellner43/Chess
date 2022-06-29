class Player
  attr_accessor :name, :color, :turns

  def initialize(color)
    @name = nil
    @color = color
    @turns = 0
  end

  def valid_name?(input)
    loop do
      return input if input.length > 0 && input =~ /\w+/

      input = gets.chomp
    end
  end
end
