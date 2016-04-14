require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    val = @store.shift
    @store.unshift(@store.pop)
    parent_idx = 0
    length = count
    @store = BinaryMinHeap.heapify_down(@store, parent_idx, length)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    child_idx = @store.length - 1
    length = count
    @store = BinaryMinHeap.heapify_up(@store, child_idx, length)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child_1 = 2 * parent_index + 1
    child_2 = 2 * parent_index + 2
    [child_1, child_2].select { |el| el < len && !el.nil?}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    ((child_index - 1)/2).floor
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    children = BinaryMinHeap.child_indices(len, parent_idx)

    while children.count != 0
      if children.count == 1
        if prc.call(array[children.first], array[parent_idx]) != 1
          array[parent_idx], array[children.first] = array[children.first], array[parent_idx]
          parent_idx = children.first
        else
          break
        end
      elsif prc.call(array[children[0]], array[children[1]]) != 1 && prc.call(array[children[0]], array[parent_idx]) != 1
        array[parent_idx], array[children[0]] = array[children[0]], array[parent_idx]
        parent_idx = children[0]
      elsif prc.call(array[children[1]], array[children[0]]) != 1 && prc.call(array[children[1]], array[parent_idx]) != 1
        array[parent_idx], array[children[1]] = array[children[1]], array[parent_idx]
        parent_idx = children[1]
      else
        return array
      end

      children = BinaryMinHeap.child_indices(len, parent_idx)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|el1, el2| el1 <=> el2}
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    while prc.call(array[child_idx],array[parent_idx]) != 1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      child_idx = parent_idx
      return array if child_idx == 0
      parent_idx = BinaryMinHeap.parent_index(child_idx)
    end

    array
  end
end
