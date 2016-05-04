require 'byebug'
require_relative 'heap2'

class PriorityMap
  def initialize(&prc)
    @map = Hash.new()
    @queue = BinaryMinHeap.new { |key1, key2| prc.call(self.map[key1], self.map[key2]) }
  end

  def [](key)
    @map[key]
  end

  def []=(key, value)
    if has_key?(key)
      update(key, value)
    else
      insert(key, value)
    end

    value
  end

  def count
    @map.keys.length
  end

  def empty?
    @map.empty?
  end

  def extract
    debugger
    extracted_key = @queue.extract
    extracted_value = @map.delete(extracted_key)
    return [extracted_key, extracted_value]
  end

  def has_key?(key)
    @map.has_key?(key)
  end

  protected
  attr_accessor :map, :queue

  def insert(key, value)
    @map[key] = value
    @queue.push(key)
  end

  def update(key, value)
    @map[key] = value
    @queue.reduce!(key)
  end
end
