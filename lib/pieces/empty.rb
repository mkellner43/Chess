class Empty
  attr_reader :color
  attr_accessor :previous_location, :location

  def initialize
    @color = nil
    @location = nil
    @previous_location = nil
  end

  def to_s
    ' '
  end
end
