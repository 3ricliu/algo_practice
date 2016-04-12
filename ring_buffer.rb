require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    @length -= 1
    val = (@start_idx + @length) % @capacity
    @store[val]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    last_index = (@start_idx + @length) % @capacity
    @length += 1
    @store[last_index] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    val = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity

    idx = (@start_idx - 1) % @capacity
    @length += 1
    @start_idx = idx
    @store[idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (raise "index out of bounds") if @length == 0 || @length <= index
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)

    @length.times do |i|
      new_store[i] = self[i]
    end

    @capacity = new_capacity
    @start_idx = 0
    @store = new_store
  end
end
