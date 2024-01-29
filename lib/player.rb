class Player
  def initialize(name)
    @name = name
    @gesture = nil
  end
  attr_reader :name
  attr_accessor :gesture
end
