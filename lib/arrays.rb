class Array
  def my_uniq
    [].tap do |arr|
      self.each do |el|
        arr << el unless arr.include?(el)
      end
    end
  end

  def two_sum
    [].tap do |arr|
      self.each_with_index do |val1, idx1|
        self.each_with_index do |val2, idx2|
          next if idx2 <= idx1

          arr << [idx1, idx2] if val1 + val2 == 0
        end
      end
    end
  end

  def my_transpose
    transpose = []
    self.each_index do |row_idx|
      col = []
      self.each do |row|
        col << row[row_idx]
      end
      transpose << col
    end
    transpose
  end
end