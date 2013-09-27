class Deck

  def initialize
    @cards = init_cards
  end

  def count
    @cards.length
  end

  def next
    raise "Empty deck" if @cards.empty?

    @cards.pop
  end

  private
  def init_cards
    cards = []
    [Card::HEART, Card::DIAMOND, Card::SPADE, Card::CLUB].each do |suit|
      (1..13).each do |val|
        cards << Card.new(val, suit)
      end
    end
    cards.shuffle
  end
end