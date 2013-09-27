require "rspec"
require "hand"

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


    context "when no pairs" do
      before do
        (1..5).each { |val| hand.add_card(double("card #{val}", :value => val)) }
      end

      describe "#result" do
        it "should return :no pair" do
          expect(hand.result).to eq :no_pair
        end


      end

      describe "#high_card" do
        it "should return 5" do
          expect(hand.high_card).to eq 5
        end
      end
    end
  end
end
