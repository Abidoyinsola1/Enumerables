module Enumerable
    def my_each
     each  do |i|
      yield i   
      end
      self
    end
  end

 



  a = [1, 2, 3, 5] 
     
  a.my_each { |i| print  i  }
