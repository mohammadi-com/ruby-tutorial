require "thread"

connections = [
  ["London", "Cambridge"],
  ["London", "Oxford"],
  ["Oxford", "Bristol"],
  ["Cambridge", "Norwich"],
  ["Norwich", "Leeds"],
  ["Leeds", "Manchester"],
  ["Manchester", "Liverpool"],
  ["Bristol", "Cardiff"],
  ["Cardiff", "Liverpool"]
]

class Graph
  attr_reader :graph
  def initialize(connections)
    @graph = Hash.new {|hash, key| hash[key] = []}
    connections.each do |source, destination|
      @graph[source] << destination
      @graph[destination] << source
    end
  end

  def [](key)
    @graph[key]
  end
end


def shortest_route(graph, start, goal)
  visited = {start => true}
  queue = Queue.new
  queue << [start]

  until queue.empty?
    path = queue.pop
    last_hop = path[-1]
    
    return path if last_hop == goal

    for hop in graph[last_hop]
      next if visited[hop]
      visited[hop] = true
      queue << path + [hop]
    end
  end
  nil
end

graph = Graph.new(connections)
p shortest_route(graph, "London", "Liverpool")