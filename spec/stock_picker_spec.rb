require "rspec"
require "stock_picker"

describe StockPicker do
  subject(:picker) { StockPicker.new }
  let(:prices) { [2, 3, 6, 3, 9, 13, 16, 64, 1] }

  describe "#max_profit" do
    it "should not return profit" do
      picker.max_profit(prices).should_not == 62
    end

    it "should return indices" do
      picker.max_profit(prices).should == [0, 7]
    end

    it "should return [0, 1] for constant loss" do
      picker.max_profit([14, 13, 12, 11, 10]).should == [0, 1]
    end

    it "should not return sell date before buy date" do
      picker.max_profit(prices).should_not == [7, 8]
    end
  end
end