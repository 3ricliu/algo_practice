require_relative "heap"

class Array
  def heap_sort!
    # Bad way to do it because it takes up an extra O(n) space complexity
    # heap = BinaryMinHeap.new
    # self.each do |element|
    #   heap.push(element)
    # end
    #
    # self.length.times do |i|
    #   self[i] = heap.extract
    # end
    #
    # self
    2.upto(self.length) do |heap_size|
      BinaryMinHeap.heapify_up(self, heap_size - 1, self.length)
    end

    self.length.downto(2) do |heap_size|
      self[heap_size - 1], self[0] = self[0], self[heap_size - 1]
      BinaryMinHeap.heapify_down(self, 0, heap_size - 1)
    end

    self.reverse!
  end
end
