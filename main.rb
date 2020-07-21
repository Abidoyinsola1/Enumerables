module Enumerable
  def my_each
    each do |i|
      yield i
    end
    self
  end

  def my_each_with_index
    0.upto(length - 1) do |i|
      yield(self[i], i)
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

  def my_count(*)
    return length unless block_given?

    count = 0
    my_each do |i|
      count += 1 if yield i
    end
    count
  end

  def my_map(val = nil)
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

  def my_inject(val = 0)
    i = 0
    acc = val

    while i < length
      acc = yield(acc, self[i])
      i += 1
    end
    acc
  end
end

def multiply_els(arr)
  arr.my_inject { |result, val| result * val }
end
