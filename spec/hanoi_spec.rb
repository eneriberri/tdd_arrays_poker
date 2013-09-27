require 'rspec'
require 'hanoi'

describe Hanoi do
  subject(:hanoi) { Hanoi.new }

  describe "#initialize" do
    it "has 3 pegs" do
      hanoi.pegs.length.should == 3
    end

    it "has 3 disks on the peg1" do
      hanoi.peg1.length.should == 3
    end

    it "0 disks on peg2 and peg3" do
      hanoi.peg2.length.should == 0
      hanoi.peg3.length.should == 0
    end
  end


  describe "#move_disc" do
    context "when there is valid start_peg and end_peg" do
      it "moving smallest disc to empty peg" do
        hanoi.move_disc(1, 2)

        hanoi.peg1.length.should == 2
        hanoi.peg2.length.should == 1
      end

      it "moving medium disc to empty peg" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)

        hanoi.peg1.length.should == 1
        hanoi.peg3.length.should == 1
      end

      it "moving large disc to empty peg" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 2)

        hanoi.peg1.length.should == 0
        hanoi.peg2.length.should == 1
      end

      it "moving small disc on top of medium" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)

        hanoi.peg3.length.should == 2
      end

      it "moving small disc on top of large" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 2)
        hanoi.move_disc(3, 2)

        hanoi.peg2.length.should == 2
      end

      it "moving medium disc on top of large" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 2)
        hanoi.move_disc(3, 1)
        hanoi.move_disc(3, 2)

        hanoi.peg2.length.should == 2
      end
    end

    context "when there is an invalid input" do
      describe "with non-existent start peg" do
        it "is below 1" do
          expect { hanoi.move_disc(0, 2) }.to raise_error(ArgumentError)
        end

        it "is above 3" do
          expect { hanoi.move_disc(4, 2) }.to raise_error(ArgumentError)
        end
      end

      describe "with non-existent end peg" do
        it "is above 3" do
          expect { hanoi.move_disc(1, 4) }.to raise_error(ArgumentError)
        end

        it "is below 1" do
          expect { hanoi.move_disc(1, 0) }.to raise_error(ArgumentError)
        end
      end

      it "has empty start peg" do
        expect { hanoi.move_disc(2, 3) }.to raise_error(ArgumentError)
      end

      describe "start disc is larger than end disc" do
        before do
          hanoi.move_disc(1, 2)
          hanoi.move_disc(1, 3)
        end

        it "cannot move medium onto small" do
          expect { hanoi.move_disc(3, 2) }.to raise_error(ArgumentError)
        end

        it "cannot move large onto small" do
          expect { hanoi.move_disc(1, 2) }.to raise_error(ArgumentError)
        end

        it "cannot move large onto medium" do
          expect { hanoi.move_disc(1, 3) }.to raise_error(ArgumentError)
        end
      end
    end
  end


  describe "#game_won?" do
    context "when all discs are on peg 2" do
      it "should be true" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 2)
        hanoi.move_disc(3, 1)
        hanoi.move_disc(3, 2)
        hanoi.move_disc(1, 2)

        hanoi.game_won?.should be_true
      end
    end

    context "when all discs are on peg 3" do
      it "should be true" do
        hanoi.move_disc(1, 3)
        hanoi.move_disc(1, 2)
        hanoi.move_disc(3, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 1)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 3)

        hanoi.game_won?.should be_true
      end
    end

    context "when all discs are back on peg 1" do
      it "should be false" do
        hanoi.move_disc(1, 3)
        hanoi.move_disc(3, 1)

        hanoi.game_won?.should be_false
      end
    end

    context "when peg 1 is empty and other pegs not full" do
      it "should be false" do
        hanoi.move_disc(1, 2)
        hanoi.move_disc(1, 3)
        hanoi.move_disc(2, 3)
        hanoi.move_disc(1, 2)
        hanoi.move_disc(3, 1)
        hanoi.move_disc(3, 2)
        hanoi.move_disc(1, 3)

        hanoi.game_won?.should be_false
      end
    end
  end
end