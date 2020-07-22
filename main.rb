module Enumerable
  def my_each
    return unless block_given?

    each do |i|
      yield i
    end
    self
  end

  def my_each_with_index
    return unless block_given?

    0.upto(length - 1) do |i|
      yield i, index
      index + 1
    end
  end

  def my_select
    return unless block_given?

    result = []
    my_each do |i|
      result.push(i) if yield i
    end
    result
  end

  def my_all?(*val)
    result = true
    if !val[0].nil?
      my_each { |i| result = false unless val[0] == i }
    elsif !block_given?
      my_each { |i| result = false unless i }
    else
      my_each { |i| result = false unless yield(i) }
    end
    result
  end

  def my_any?(*val)
    result = true
    if !val[0].nil?
      my_each { |i| result = false unless val[0] == i }
    elsif !block_given?
      my_each { |i| result = false unless i }
    else
      my_each { |i| result = false unless yield(i) }
    end
    result
  end

  def my_none?(*val)
    result = false
    if !val[0].nil?
      my_each { |i| result = false unless val[0] == i }
    elsif !block_given?
      my_each { |i| result = false unless i }
    else
      my_each { |i| result = false if yield(i) }
    end
    result
  end

  def my_count(*)
    return length unless block_given?

    count = 0
    my_each do |i|
      count += 1 if yield i
    end
    count
  end

  def my_map(val = nil)
    return to_enum(:my_map) unless block_given?

    result = []

    my_each do |i|
      if val
        result.push((val.call i))
      else
        result.push(yield i)
      end
    end
    result
  end

  def my_inject(first_aug = nil)
    i = 0
    acc = first_aug
    sym = (first_aug if first_aug == Symbol || String)
    if block_given?
      while i < length
        if acc.nil?
          acc = self[0]
          i += 1
          next
        end
        acc = yield(acc, self[i])
        i += 1
      end
    elsif !sym.nil? && sym.class == Symbol
      while i < length
        acc = acc.send(sym, self[i])
        i += 1
      end
    elsif !sym.nil? && sym.class == String && %r{[+-/*]}.match(sym)
      while i < length
        acc = acc.send(sym, self[i])
        i += 1
      end
    end
    acc
  end
end

def multiply_els(arr)
  arr.my_inject(1) { |val, i| val * i }
end
