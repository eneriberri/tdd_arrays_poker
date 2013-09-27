require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    its(:count) { should == 52 }

    describe "should have all the cards of each suit" do
      let(:cards) do
        cards = Hash.new { |hash, key| hash[key] = [] }
        52.times do
          card = deck.next
          cards[card.suit] << card
        end
        cards
      end

      it "should have 13 cards per suit" do
        cards.all? { |suit, arr| arr.uniq.length == 13 }.should be_true
      end

      it "should have every val for each suit" do
        cards.all? do |suit, arr|
          expect(arr.map { |card| card.value }.sort).to eq((1..13).to_a)
        end
      end
    end
  end

  describe "#next" do
    it "should return 52 cards" do
      expect { 52.times { deck.next } }.not_to raise_error
    end

    it "should not return 53 cards" do
      52.times { deck.next }

      expect { deck.next }.to raise_error
    end
  end
end