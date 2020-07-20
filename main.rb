module Enumerable
  def my_each
    for i in 0...self.length
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

  def my_map(arr)
    arr = self.Array
    result = []

    my_each do |i|
      result>>(yield i)
    end 
    result
  end

  def my_inject
    
  end

end

a = [1, 2, 3, 5]
a.my_each { |i| print i * 4 }
a.each_with_index { |i| puts "#{i} is the value of a" }
puts a.my_select(&:even?)
puts(a.my_all? { |i| i > 0})
puts(a.my_any? { |i| i > 0})
puts(a.my_none? { |i| i > 0})
puts(a.my_count)
puts(a.map {|i| i*i})
