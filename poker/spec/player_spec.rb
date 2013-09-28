require "rspec"
require "player"

describe Player do
  subject(:player) { Player.new(1000) }

  describe "#initialize" do
    its(:pot) { should == 1000 }
    its(:hand) { should be_nil }
  end

  describe "#add_hand" do
    let(:hand) { double("hand") }

    before do
      player.hand = hand
    end

    its(:hand) { should == hand }
  end


end