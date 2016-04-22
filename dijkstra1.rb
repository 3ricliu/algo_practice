require 'byebug'
require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source_vertex)
  locked_in_paths = Hash.new()
  possible_paths = Hash.new {|hash, key| hash[key] = {cost: 0, last_edge: nil}}

  possible_paths[source_vertex]

  until possible_paths.empty?
    vertex = select_possible_paths(possible_paths)

    locked_in_paths[vertex] = possible_paths[vertex]
    possible_paths.delete(vertex)

    add_next_verticies(locked_in_paths, possible_paths, vertex)
  end

  locked_in_paths
end


def select_possible_paths(possible_paths)
  vertex = possible_paths.min_by do |path, data|
    data[:cost]
  end

  vertex.first
end

def add_next_verticies(locked_in_paths, possible_paths, vertex)
  vertex.out_edges.each do |edge|
    next_vertex = edge.to_vertex
    next_vertex_cost = edge.cost + locked_in_paths[vertex][:cost]

    next if locked_in_paths.has_key?(next_vertex)

    next if possible_paths.has_key?(next_vertex) && possible_paths[next_vertex][:cost] <= next_vertex_cost

    possible_paths[next_vertex][:cost] = next_vertex_cost
    possible_paths[next_vertex][:last_edge] = edge
  end
end

# have locked_in_paths
# have possible_paths => cost && previous_edge
# store beginning vertex to possible_paths
# until possible_paths is empty, find the shortest next path
# add that to locked_in_paths, with prev data
# use that vertex's out_edges to generate new vertexes in possible_paths
# rinse + repeat, after that locked_in_paths should be complete
