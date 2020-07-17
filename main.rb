module Enumerable
    def my_each
     each  do |i|
      yield i   
      end
      self
    end

def my_each_with_index
  0.upto(self.length-1) do |i|
    yield(self[i], i)
  end

  self
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
    unless yield i 
        result = false
    end
end
    result
end
def my_any?
  result = false
  my_each do |i|
  if yield i 
      result = true
  end
end
  result
end
def my_none?
  result = true
  my_each do |i|
  if yield i 
      result = false
  end
end
  result
end

def my_count
  return self.length unless block_given?
count = 0
my_each do |i|
if yield i
  count += 1 
end
end
count
end
            
end

a = [1, 2, 3, 5] 
a.my_each { |i| print  i * 4 }
a.each_with_index { |i| puts "#{i} is the value" }
puts a.my_select(&:even?)
puts(a.my_all? { |i| i > 0})
puts(a.my_count)
