using DataStructures: PriorityQueue, enqueue!, dequeue!

mutable struct Node
    ip::Int
    neighbours::Array{Tuple{Node,Int}}
    risk::Union{Float64, Nothing}
    predecessor::Union{Node, Nothing}
    probability::Float64
end

Node(ip) = Node(ip, [], nothing, nothing, 0.0)


# Oppgave 1
function initialize_single_source!(graph, start)
    for node in graph
        node.risk = typemax(Float64)
        node.predecessor = Nothing
    end

    start.risk = 0.0
end

# Oppgave 2
function relax!(from_node,to_node,cost)
    risk = from_node.risk + cost/to_node.probability

    if to_node.risk > risk
        to_node.risk = risk
        to_node.predecessor = from_node
    end
end

# Oppgave 3
function dijkstra!(graph,start)
    initialize_single_source!(graph, start)

    Q = PriorityQueue{Node, Float64}()

    for node in graph
        enqueue!(Q, node, node.risk)
    end

    while !isempty(Q)
        node = dequeue!(Q)
        for (neighbour, cost) in node.neighbours
            relax!(node, neighbour, cost)
            if haskey(Q, neighbour)
                Q[neighbour] = neighbour.risk
            end
        end
    end
end


# Oppgave 4
function bellman_ford!(graph,start)
    initialize_single_source!(graph, start)

    for i in 1:length(graph)-1
        for node in graph
            for (neighbour, cost) in node.neighbours
                relax!(node, neighbour, cost)
            end
        end
    end

    for node in graph
        for (neighbour, cost) in node.neighbours
            risk = node.risk + cost/neighbour.probability
            if node.risk > risk
                return false
            end
        end
    end
    return true
end



