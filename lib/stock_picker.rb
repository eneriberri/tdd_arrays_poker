class StockPicker
  def max_profit(prices)
    max = 0
    buy_index, sell_index = 0, 1
    prices.each_with_index do |price, index1|
      (index1+1...prices.length).each do |index2|
        if prices[index2] - price > max
          max = prices[index2] - price
          buy_index = index1
          sell_index = index2
        end
      end
    end

    [buy_index, sell_index]
  end
end