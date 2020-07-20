module Enumerable
  def my_each
    for i in 0...length
      yield self[i]
    end
    self
  end

  def my_each_with_index
    0.upto(length - 1) do |i|
      yield([i], i)
    end
  end

  def my_select
    result = []
    my_each do |i|
      result.push(i) if yield i
    end
    result
  end

  def my_all?
    result = true
    my_each do |i|
      result = false unless yield i
    end
    result
  end

  def my_any?
    result = false
    my_each do |i|
      result = true if yield i
    end
    result
  end

  def my_none?
    result = true
    my_each do |i|
      result = false if yield i
    end
    result
  end

  def my_count
    return length unless block_given?

    count = 0
    my_each do |i|
      count += 1 if yield i
    end
    count
  end

  def my_map(_arr)
    _arr = self._arr
    result = []

    my_each do |i|
      result >> (yield i)
    end
    result
  end

  def my_inject(*val)
    first_aug, second_aug = val
    i = 0
    acc = first_aug
    acc = self[0] if first_aug.nil?
    sym = second_aug if second_aug
    elsif first_aug == Symbol || String
      sym = first_aug
    else
        sym = nil
    end
    if block_given?
   while i < self.length
      acc = yield(acc, self[i])
     i += 1
    end
    elsif !sym.nil? && sym.class == Symbol
   while i < self.length
      acc = acc.send(sym, self[i])
      i += 1
    end
    elsif !sym.nil? && sym.class == String && %r{[+-/*]}.match(sym)
      while i < self.length
        acc = acc.send(sym, self[i])
       i += 1
      end
    end
    acc
  end
end
