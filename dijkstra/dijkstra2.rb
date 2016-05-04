require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  locked_in = {}
  possible_paths = PriorityMap.new do |vertex1, vertex2|
    vertex1[:cost] <=> vertex2[:cost]
  end

  possible_paths[source] = {cost: 0, back_edges: nil}

  # Runs |V| times max, since a new node is "locked in" each round.
  until possible_paths.empty?
    # O(log |V|) time.
    vertex, data = possible_paths.extract
    locked_in[vertex] = data

    find_next_vertices(vertex, locked_in, possible_paths)
  end

  locked_in.to_a
end


def find_next_vertices (vertex, locked_in, possible_paths)
  current_path_cost = locked_in[vertex][:cost]

  # We'll run this |E| times overall.
  vertex.out_edges.each do |edge|
    next_vertex = edge.to_vertex

    next if locked_in.has_key?(next_vertex)
    next_vertex_cost = edge.cost + current_path_cost

    next if possible_paths.has_key?(next_vertex) &&
             possible_paths[next_vertex][:cost] <= next_vertex_cost

    # takes O(log |V|) time
    possible_paths[next_vertex] = {cost: next_vertex_cost, back_edges: next_vertex.in_edges}
  end
end
