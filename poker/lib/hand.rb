class Hand
  def initialize
    @cards = []
  end

  def count
    @cards.length
  end

  def add_card(card)
    raise "Too many cards" if count == 5

    @cards << card
  end

  def result
    raise "Not enough cards" unless count == 5

    return :no_pair if @cards.uniq.length == 5
  end

  def high_card
    max = 1
    @cards.each do |card|
      max = card.value if card.value > max
    end
    max
  end

end