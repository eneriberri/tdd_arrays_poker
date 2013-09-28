require "rspec"
require "hand"
require "card"

describe Hand do
  subject(:hand) { Hand.new }

  describe "#initialize" do
    its(:count) { should == 0 }
  end

  describe "#count" do
    it "should have count 0" do
      expect(hand.count).to eq 0
    end

    context "after dealing" do
      it "should have count 5" do
        5.times do |i|
          hand.add_card(double("card #{i}"))
        end

        expect(hand.count).to eq 5
      end
    end
  end



  describe "#add_card" do
    it "should raise error adding sixth card" do
      5.times { hand.add_card(double("card")) }

      expect { hand.add_card(double("card")) }.to raise_error
    end

    it "should add one card" do
      hand.add_card(double("card"))

      expect(hand.count).to eq 1
    end
  end



  describe "find result" do
    context "when incomplete hand" do
      it "should throw an error" do
        expect { hand.result }.to raise_error
      end
    end


    let(:no_pair_hand) do
      no_pair_hand = Hand.new
      (2..5).each { |val| no_pair_hand.add_card(double("card #{val}", :value => val, :suit => Card::HEART)) }
      no_pair_hand.add_card(double("card 5", :value => 7, :suit => Card::CLUB))

      no_pair_hand
    end

    context "when no pairs" do
      describe "#result" do
        it "should return :no pair" do
          expect(no_pair_hand.result).to eq :no_pair
        end
      end

      describe "#high_card" do
        it "should return 7" do
          expect(no_pair_hand.high_card).to eq 7
        end
      end
    end


    let(:one_pair_hand) do
      one_pair_hand = Hand.new
      one_pair_hand.add_card(double("card 1", :value => 1, :suit => Card::HEART))
      one_pair_hand.add_card(double("card 2", :value => 1, :suit => Card::CLUB))
      (3..5).each do |val|
        one_pair_hand.add_card(double("card #{val}", :value => val, :suit => Card::DIAMOND))
      end

      one_pair_hand
    end


    context "when one pair" do
      describe "#result" do
        it "should return :one_pair" do
          expect(one_pair_hand.result).to eq :one_pair
        end
      end

      describe "#high_card" do
        it "should return 1" do
          expect(one_pair_hand.high_card).to eq 1
        end
      end
    end


    let(:two_pair_hand) do
      two_pair_hand = Hand.new
      two_pair_hand.add_card(double("card 1", :value => 3, :suit => Card::HEART))
      two_pair_hand.add_card(double("card 2", :value => 3, :suit => Card::CLUB))
      two_pair_hand.add_card(double("card 3", :value => 2, :suit => Card::HEART))
      two_pair_hand.add_card(double("card 4", :value => 2, :suit => Card::CLUB))
      two_pair_hand.add_card(double("card 5", :value => 4, :suit => Card::HEART))

      two_pair_hand
    end

    context "when two pair" do
      describe "#result" do
        it "should return :two_pair" do
          expect(two_pair_hand.result).to eq :two_pair
        end
      end

      describe "#high_card" do
        it "should return 4" do
          expect(two_pair_hand.high_card).to eq 4
        end
      end
    end


    let(:three_of_a_kind_hand) do
      three_of_a_kind_hand = Hand.new
      three_of_a_kind_hand.add_card(double("card 1", :value => 5, :suit => Card::HEART))
      three_of_a_kind_hand.add_card(double("card 2", :value => 5, :suit => Card::CLUB))
      three_of_a_kind_hand.add_card(double("card 3", :value => 5, :suit => Card::SPADE))
      three_of_a_kind_hand.add_card(double("card 4", :value => 2, :suit => Card::CLUB))
      three_of_a_kind_hand.add_card(double("card 5", :value => 3, :suit => Card::HEART))

      three_of_a_kind_hand
    end

    context "when three of a kind" do
      describe "#result" do
        it "should return :three_of_a_kind" do
          expect(three_of_a_kind_hand.result).to eq :three_of_a_kind
        end
      end

      describe "#high_card" do
        it "should return 5" do
          expect(three_of_a_kind_hand.high_card).to eq 5
        end
      end
    end


    let(:straight_hand) do
      straight_hand = Hand.new
      straight_hand.add_card(double("card 1", :value => 1, :suit => Card::HEART))
      straight_hand.add_card(double("card 2", :value => 3, :suit => Card::CLUB))
      straight_hand.add_card(double("card 3", :value => 2, :suit => Card::HEART))
      straight_hand.add_card(double("card 4", :value => 4, :suit => Card::CLUB))
      straight_hand.add_card(double("card 5", :value => 5, :suit => Card::HEART))

      straight_hand
    end

    context "when a straight" do
      describe "#result" do
        it "should return :straight" do
          expect(straight_hand.result).to eq :straight
        end
      end

      describe "#high_card" do
        it "should return 1" do
          expect(straight_hand.high_card).to eq 1
        end
      end
    end


    let(:flush_hand) do
      flush_hand = Hand.new
      flush_hand.add_card(double("card 1", :value => 2, :suit => Card::HEART))
      flush_hand.add_card(double("card 2", :value => 3, :suit => Card::HEART))
      flush_hand.add_card(double("card 3", :value => 5, :suit => Card::HEART))
      flush_hand.add_card(double("card 4", :value => 7, :suit => Card::HEART))
      flush_hand.add_card(double("card 5", :value => 9, :suit => Card::HEART))

      flush_hand
    end

    context "when a flush" do
      describe "#result" do
        it "should return :flush" do
          expect(flush_hand.result).to eq :flush
        end
      end

      describe "#high_card" do
        it "should return 9" do
          expect(flush_hand.high_card).to eq 9
        end
      end
    end


    let(:full_house_hand) do
      full_house_hand = Hand.new
      full_house_hand.add_card(double("card 1", :value => 1, :suit => Card::HEART))
      full_house_hand.add_card(double("card 2", :value => 1, :suit => Card::CLUB))
      full_house_hand.add_card(double("card 3", :value => 2, :suit => Card::HEART))
      full_house_hand.add_card(double("card 4", :value => 2, :suit => Card::CLUB))
      full_house_hand.add_card(double("card 5", :value => 2, :suit => Card::DIAMOND))

      full_house_hand
    end

    context "when a full house" do
      describe "#result" do
        it "should return :full_house" do
          expect(full_house_hand.result).to eq :full_house
        end
      end

      describe "#high_card" do
        it "should return 1" do
          expect(full_house_hand.high_card).to eq 1
        end
      end
    end


    let(:four_of_a_kind_hand) do
      four_of_a_kind_hand = Hand.new
      four_of_a_kind_hand.add_card(double("card 1", :value => 2, :suit => Card::HEART))
      four_of_a_kind_hand.add_card(double("card 2", :value => 2, :suit => Card::CLUB))
      four_of_a_kind_hand.add_card(double("card 3", :value => 2, :suit => Card::SPADE))
      four_of_a_kind_hand.add_card(double("card 4", :value => 2, :suit => Card::DIAMOND))
      four_of_a_kind_hand.add_card(double("card 5", :value => 3, :suit => Card::HEART))

      four_of_a_kind_hand
    end

    context "when a four of a kind" do
      describe "#result" do
        it "should return :four_of_a_kind" do
          expect(four_of_a_kind_hand.result).to eq :four_of_a_kind
        end
      end

      describe "#high_card" do
        it "should return 3" do
          expect(four_of_a_kind_hand.high_card).to eq 3
        end
      end
    end


    let(:straight_flush_hand) do
      straight_flush_hand = Hand.new
      straight_flush_hand.add_card(double("card 1", :value => 1, :suit => Card::HEART))
      straight_flush_hand.add_card(double("card 2", :value => 3, :suit => Card::HEART))
      straight_flush_hand.add_card(double("card 3", :value => 2, :suit => Card::HEART))
      straight_flush_hand.add_card(double("card 4", :value => 5, :suit => Card::HEART))
      straight_flush_hand.add_card(double("card 5", :value => 4, :suit => Card::HEART))

      straight_flush_hand
    end

    context "when a straight flush" do
      describe "#result" do
        it "should return :straight_flush" do
          expect(straight_flush_hand.result).to eq :straight_flush
        end
      end

      describe "#high_card" do
        it "should return 1" do
          expect(straight_flush_hand.high_card).to eq 1
        end
      end
    end


    let(:royal_flush_hand) do
      royal_flush_hand = Hand.new
      royal_flush_hand.add_card(double("card 1", :value => 10, :suit => Card::HEART))
      royal_flush_hand.add_card(double("card 2", :value => 12, :suit => Card::HEART))
      royal_flush_hand.add_card(double("card 3", :value => 11, :suit => Card::HEART))
      royal_flush_hand.add_card(double("card 4", :value => 1, :suit => Card::HEART))
      royal_flush_hand.add_card(double("card 5", :value => 13, :suit => Card::HEART))

      royal_flush_hand
    end

    context "when a royal flush" do
      describe "#result" do
        it "should return :royal_flush" do
          expect(royal_flush_hand.result).to eq :royal_flush
        end
      end

      describe "#high_card" do
        it "should return 1" do
          expect(royal_flush_hand.high_card).to eq 1
        end
      end
    end


    describe "comparing winning hands" do
      describe "royal flush" do
        it "should beat straight flush" do
          expect(royal_flush_hand <=> straight_flush_hand).to eq 1
        end

        it "should beat four of a kind" do
          expect(royal_flush_hand <=> four_of_a_kind_hand).to eq 1
        end

        it "should beat full house" do
          expect(royal_flush_hand <=> full_house_hand).to eq 1
        end

        it "should beat flush" do
          expect(royal_flush_hand <=> flush_hand).to eq 1
        end

        it "should beat straight" do
          expect(royal_flush_hand <=> straight_hand).to eq 1
        end

        it "should beat three of a kind" do
          expect(royal_flush_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(royal_flush_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(royal_flush_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(royal_flush_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "straight flush" do
        it "should beat four of a kind" do
          expect(straight_flush_hand <=> four_of_a_kind_hand).to eq 1
        end

        it "should beat full house" do
          expect(straight_flush_hand <=> full_house_hand).to eq 1
        end

        it "should beat flush" do
          expect(straight_flush_hand <=> flush_hand).to eq 1
        end

        it "should beat straight" do
          expect(straight_flush_hand <=> straight_hand).to eq 1
        end

        it "should beat three of a kind" do
          expect(straight_flush_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(straight_flush_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(straight_flush_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(straight_flush_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "four of a kind" do
        it "should beat full house" do
          expect(four_of_a_kind_hand <=> full_house_hand).to eq 1
        end

        it "should beat flush" do
          expect(four_of_a_kind_hand <=> flush_hand).to eq 1
        end

        it "should beat straight" do
          expect(four_of_a_kind_hand <=> straight_hand).to eq 1
        end

        it "should beat three of a kind" do
          expect(four_of_a_kind_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(four_of_a_kind_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(four_of_a_kind_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(four_of_a_kind_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "full house" do
        it "should beat flush" do
          expect(full_house_hand <=> flush_hand).to eq 1
        end

        it "should beat straight" do
          expect(full_house_hand <=> straight_hand).to eq 1
        end

        it "should beat three of a kind" do
          expect(full_house_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(full_house_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(full_house_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(full_house_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "flush" do
        it "should beat straight" do
          expect(flush_hand <=> straight_hand).to eq 1
        end

        it "should beat three of a kind" do
          expect(flush_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(flush_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(flush_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(flush_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "straight" do
        it "should beat three of a kind" do
          expect(straight_hand <=> three_of_a_kind_hand).to eq 1
        end

        it "should beat two pair" do
          expect(straight_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(straight_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(straight_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "three of a kind" do
        it "should beat two pair" do
          expect(three_of_a_kind_hand <=> two_pair_hand).to eq 1
        end

        it "should beat one pair" do
          expect(three_of_a_kind_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(three_of_a_kind_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "two pair" do
        it "should beat one pair" do
          expect(two_pair_hand <=> one_pair_hand).to eq 1
        end

        it "should beat no pair" do
          expect(two_pair_hand <=> no_pair_hand).to eq 1
        end
      end


      describe "one pair" do
        it "should beat no pair" do
          expect(one_pair_hand <=> no_pair_hand).to eq 1
        end
      end
    end

    describe "comparing tying hands" do

      describe "royal flush" do
        let(:other_royal_flush_hand) do
          other_royal_flush_hand = Hand.new
          other_royal_flush_hand.add_card(double("card 1", :value => 10, :suit => Card::CLUB))
          other_royal_flush_hand.add_card(double("card 2", :value => 12, :suit => Card::CLUB))
          other_royal_flush_hand.add_card(double("card 3", :value => 11, :suit => Card::CLUB))
          other_royal_flush_hand.add_card(double("card 4", :value => 1, :suit => Card::CLUB))
          other_royal_flush_hand.add_card(double("card 5", :value => 13, :suit => Card::CLUB))

          other_royal_flush_hand
        end

        it "should be draw" do
          expect(royal_flush_hand <=> other_royal_flush_hand).to eq 0
        end
      end


    end
  end
end
