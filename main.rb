module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    each do |i|
      yield i
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    0.upto(length - 1) do |i|
      yield self[i], i
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

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
    result = false
    if !val[0].nil?
      my_each { |i| result = true if val[0] == i }
    elsif !block_given?
      my_each { |i| result = true if i }
    else
      my_each { |i| result = true if yield(i) }
    end
    result
  end

  def my_none?(*val)
    result = true
    if !val[0].nil?
      my_each { |i| result = false if val[0] == i }
    elsif !block_given?
      my_each { |i| result = false if i }
    else
      my_each { |i| result = false if yield(i) }
    end
    result
  end

  def my_count(val = nil)
    count = 0

    if !val.nil?
      my_each { |i| count += 1 if i == val }
    elsif block_given?
      my_each { |i| count += 1 if yield(i) }
    else
      my_each { count += 1 }
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

  def my_inject(first_aug = nil, sym = nil)
    if block_given?
      acc = first_aug
      my_each { |i| acc = acc.nil? ? i : yield(acc, i) }
      raise LocalJumpError unless block_given? || !sym.empty? || !first_aug.empty?

      acc
    elsif !first_aug.nil? && (first_aug if first_aug == Symbol || String)
      raise LocalJumpError unless block_given? || !first_aug.empty?

      acc = nil
      my_each { |i| acc = acc.nil? ? i : acc.send(first_aug, i) }
      acc
    elsif !sym.nil? && (sym if sym == Symbol || String)
      raise LocalJumpError unless block_given? || !sym.empty?

      acc = first_aug
      my_each { |i| acc = acc.nil? ? i : acc.send(sym, i) }
      acc
    else
      raise LocalJumpError
    end
  end
end
def multiply_els(arr)
  arr.my_inject(1) { |val, i| val * i }
end
