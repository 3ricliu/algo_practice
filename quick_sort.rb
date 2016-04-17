require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array.drop(1).each do |num|
      num >= pivot ? right << num : left << num
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|el1,el2| el1 <=> el2}

    return array if length < 2

    pivot = QuickSort.partition(array, start, length, &prc)

    left_length = pivot - start
    right_length = length - (left_length + 1)
    QuickSort.sort2!(array, 0, left_length, &prc)
    QuickSort.sort2!(array, pivot + 1, right_length, &prc)
  end



  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|el1,el2| el1 <=> el2}
    # return start if length < 2
    pivot_idx = start
    ((start + 1) ... (start + length)).each do |idx|
      if prc.call(array[idx], array[pivot_idx]) < 1
        if idx - pivot_idx <= 1
          array[idx], array[pivot_idx] = array[pivot_idx], array[idx]
          pivot_idx = idx
        else
          array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
          array[pivot_idx + 1], array[pivot_idx] = array[pivot_idx], array[pivot_idx + 1]
          pivot_idx += 1
        end
      end
    end
    pivot_idx
  end

  # another way to do partition is by taking the last element in the array as pivot
  # initialize a swap_idx variable which starts at 0
  # then go through each of the elements in the array
  # if element is < pivot (aka last element), swap with swap_idx, swap_idx += 1
  # else, keep going
  # lastly, swap the pivot with the swap_idx, to get an evenly distributed array
end
