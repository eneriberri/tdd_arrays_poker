class Hand
  WEIGHT = {
    :royal_flush      => 10,
    :straight_flush   => 9,
    :four_of_a_kind   => 8,
    :full_house       => 7,
    :flush            => 6,
    :straight         => 5,
    :three_of_a_kind  => 4,
    :two_pair         => 3,
    :one_pair         => 2,
    :no_pair          => 1
  }


  def initialize
    @cards = []
  end

  def count
    @cards.length
  end

  def add_card(card)
    raise "Too many cards" if count == 5

    @cards << card
  end

  def result
    raise "Not enough cards" unless count == 5

    # return :no_pair if @cards.uniq.length == 5

    values = @cards.map { |card| card.value }.sort

    if flush?
      return :royal_flush if values == [1, 10, 11, 12, 13]
      return :straight_flush if straight?(values)
      return :flush
    else
      freq = frequencies(values)

      return :four_of_a_kind if freq.has_value?(4)
      return :full_house if freq.has_value?(3) && freq.has_value?(2)
      return :straight if straight?(values)
      return :three_of_a_kind if freq.has_value?(3)
      return :two_pair if freq.values.count(2) == 2
      return :one_pair if freq.has_value?(2)
      return :no_pair
    end
  end

  def high_card
    max = 2
    @cards.each do |card|
      if card.value == 1
        max = 1
      elsif card.value > max && max != 1
        max = card.value
      end
    end
    max
  end

  def <=>(other_hand)
    comp = WEIGHT[self.result] <=> WEIGHT[other_hand.result]
    if comp == 0
      #
    else
      comp
    end
  end


  private

  def flush?
    suit = nil
    @cards.all? do |card|
      suit ||= card.suit

      suit == card.suit
    end
  end

  def straight?(values)
    (0...values.length-1).each do |i|
      return false if values[i+1] - values[i] != 1
    end
    true
  end

  def frequencies(values)
    freq = Hash.new(0)
    values.each do |val|
      freq[val] += 1
    end

    freq
  end
end