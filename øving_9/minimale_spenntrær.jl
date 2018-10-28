mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

# Oppgave 1
function findset(x::DisjointSetNode)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end


# Oppgave 2
function union!(x::DisjointSetNode, y::DisjointSetNode)
    link(findset(x), findset(y))
end

function link(x::DisjointSetNode, y::DisjointSetNode)
    if x.rank > y.rank
        y.p = x
    else
        x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

# Oppgave 3
function hammingdistance(s1::String, s2::String)
    ulike = 0
    for i in 1:length(s1)
        if s1[i] != s2[i]
            ulike += 1
        end
    end
    return ulike
end