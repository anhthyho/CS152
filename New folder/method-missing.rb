class Tree
    def each_node(&block)
        @left.each_node(&block) if @left
        @yield @value
        @right.each_node(&block) if @right
      end 

  def make_introduction
    puts "Hi, my name is #{@name}.  Nice to meet you."
  end

  def method_missing(m)
    puts "Didn't understand #{m}"
  end
end


