class Hanoi
  attr_reader :peg1, :peg2, :peg3

  def initialize
    @peg1 = [3, 2, 1]
    @peg2 = []
    @peg3 = []
  end

  def pegs
    [peg1, peg2, peg3]
  end

  def move_disc(start_peg, end_peg)
    # raise ArgumentError.new unless start_peg.between?(1, 3) && end_peg.between?(1, 3)
    # raise ArgumentError.new if pegs[start_peg-1].empty?
    raise ArgumentError.new unless valid_move?(start_peg, end_peg)

    disc = pegs[start_peg-1].pop
    pegs[end_peg-1].push(disc)

    disc
  end

  def game_won?
    pegs[1..2].any? do |peg|
      peg.length == 3
    end
  end

  private

  def valid_move?(start_peg, end_peg)
    if start_peg.between?(1, 3) && end_peg.between?(1, 3)
      return false if pegs[start_peg-1].empty?

      return true if pegs[end_peg-1].empty?

      return false if pegs[start_peg-1].last > pegs[end_peg-1].last

      true
    else
      false
    end
  end
end