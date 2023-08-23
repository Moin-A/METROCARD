require 'pry'
require_relative 'Graph_class_methods'
class Graph < Graph_class_methods
    @@vertex 
    @edges
    attr_accessor :edges, :vertex
  
    def initialize        
      @edges = {}     
    end

   def add_vertex(vertex)
    edges[vertex]={}
   end

   def add_edges (origin,destination,*weight)
    edges[origin][destination] = weight.empty? ? 0:weight.first
   end
end 
  
 graph=Graph.new()

puts  graph.add_vertex(1)
puts  graph.add_vertex(2)
puts  graph.add_edges(1,2,6)
puts  graph.add_vertex(3)
puts  graph.add_vertex(4)
puts  graph.add_vertex(5)
puts  graph.add_edges(2,3,8)
puts  graph.add_edges(3,4,10)
puts  graph.add_edges(4,5,100)
puts  graph.add_edges(4,3,100)
puts  graph.add_edges(1,5,88)
puts  graph.add_edges(1,3,88)
 puts graph.edges