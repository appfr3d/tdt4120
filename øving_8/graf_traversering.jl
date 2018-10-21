mutable struct Node
    id::Int
    neighbours::Array{Node}
    color::Union{String, Nothing}
    distance::Union{Int, Nothing}
    predecessor::Union{Node, Nothing}
end
Node(id) = Node(id, [], nothing, nothing, nothing)

# Oppgave 1
function makenodelist(adjacencylist)
    list = []

    for i in 1:length(adjacencylist)
        push!(list, Node(i))
    end

    for i in 1:length(list)
        for n in adjacencylist[i]
            push!(list[i].neighbours, list[n])
        end
    end

    return list
end

# Oppgave 2
using DataStructures: Queue, enqueue!, dequeue!
# Funksjonen isgoalnode(node) er gitt

function bfs!(nodes, start)
    # Alle starter med fargen hvit
    for node in nodes
        node.color = "white"
    end

    # Lager en kø og starter med å se på start
    Q = Queue{Node}()
    start.color = "gray"
    start.distance = 0
    enqueue!(Q, start)

    while !isempty(Q)
        u = dequeue!(Q)

        # Returner hvis goal-node
        if isgoalnode(u)
            return u
        end

        # Se på alle naboene og queue de hvis de er hvite
        for n in u.neighbours
            if n.color == "white"
                n.color = "gray"
                n.distance = u.distance + 1
                n.predecessor = u
                enqueue!(Q, n)
            end
        end

        # vi er nå ferdige med å se på u
        u.color = "black"
        println(u.id)
    end

    # ikke funnet goal-noden enda? returner ingenting
    return nothing
end


# Oppgave 3
function makepathto(goalnode)
    node = goalnode
    predecessor_list = [node.id]
    while node.predecessor != nothing
        push!(predecessor_list, node.predecessor.id)
        node = node.predecessor
    end

    return reverse(predecessor_list)
end











