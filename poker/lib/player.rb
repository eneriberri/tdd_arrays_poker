class Player
  attr_reader :pot
  attr_accessor :hand

  def initialize(pot)
    @pot = pot
    @hand = nil
  end


end