class Card
  include Comparable

  HEART   = :heart
  SPADE   = :spade
  DIAMOND = :diamond
  CLUB    = :club

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def <=>(other_card)
    self.value <=> other_card.value
  end
end