require "rspec"
require "card"

describe Card do
  subject(:card) { Card.new(8, Card::HEART) }
  describe "#initialize" do
    it "should retain value" do
      card.value.should == 8
    end

    it "should retain suit" do
      card.suit.should == Card::HEART
    end
  end

  describe "#<=>" do
    it "should sort cards correctly" do
      card1 = Card.new(1, Card::HEART)
      card2 = Card.new(2, Card::HEART)

      expect(card1 <=> card2).to eq -1
    end

    it "should not take into account suit" do
      card1 = Card.new(1, Card::HEART)
      card2 = Card.new(2, Card::CLUB)

      expect(card1 <=> card2).to eq -1
    end

    it "sorting works" do
      arr = [Card.new(3, Card::CLUB), Card.new(2, Card::CLUB), Card.new(1, Card::CLUB)]
      expect(arr.sort).to eq arr.reverse
    end
  end
end