require "rspec"
require "arrays"


describe Array do
  describe "#my_uniq" do
    it "should have the same output as Array#uniq" do
      arr = [1, 2, 1, 5, 3, 3, 7, 7]
      arr.my_uniq.should == arr.uniq
    end
  end

  describe "#two_sum" do
    it "should return empty array" do
      arr = [1, 2, 3]
      arr.two_sum.should == []
    end

    it "should return indices of nums that sum to 0" do
      [-1, 0, 2, -2, 1].two_sum.should == [[0, 4], [2, 3]]
    end

    it "should return correct order" do
      [-1, 0, 2, -2, 1].two_sum.should_not == [[0, 4], [2, 3], [3, 2], [4, 0]]
    end

    it "should not return same indices" do
      [0, 0].two_sum.should == [[0, 1]]
    end
  end

  describe "#my_transpose" do
    subject(:rows) do
      [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]
    end

    it "should return transpose of self" do

      cols = [
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
      ]

      rows.my_transpose.should == cols
    end

    it "should not return itself" do
      rows.my_transpose.should_not == rows
    end

  end
end