module Enumerable
    def my_each
     each  do |i|
      yield i   
      end
      self
    end

end

def my_each_with_index
    0.upto(self.length-1) do |i|
      yield(self[i], i)
    end

    self
  end


  a = [1, 2, 3, 5] 
  a.my_each { |i| print  i * 4 }

  a.each_with_index { |i| puts i[1] }
