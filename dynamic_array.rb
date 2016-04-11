require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 0
    @store = StaticArray.new(0)
  end

  # O(1)
  def [](index)
    check_index(index)
  end

  # O(1)
  def []=(index, value)
  end

  # O(1)
  def pop
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! until @length > @capacity


    @store[index] = value
  end

  # O(n): has to shift over all the elements.
  def shift
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    value = @store[index]
    value == nil ? (raise "index out of bounds") : (@store[index])
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length == 0
      @length = 1
    else
      @length = @length * 2
    end

    new_store = StaticArray.new(@length, nil)

    @capacity = 1
    i = 0
    @store.each do |bucket|
      new_store[i] = bucket
      i += 1
      @capacity += 1
    end

    @store = new_store
  end
end
