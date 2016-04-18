require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def kahn_topological_sort(vertices)
  queue = []
  in_edges = {}

  vertices.each do |vertex|
    in_edges[vertex] = vertex.in_edges.count
    queue << vertex if in_edges[vertex] == 0
  end

  removed_vertices = []

  until queue.empty?
    vertex = queue.shift
    removed_vertices << vertex

    vertex.out_edges.each do |edge|
      neighbor = edge.to_vertex

      in_edges[neighbor] -= 1
      queue.push(neighbor) if in_edges[neighbor] == 0
    end
  end

  removed_vertices
end
