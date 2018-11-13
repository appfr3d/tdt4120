# Oppgave 1
function floyd_warshall(adjacency_matrix, nodes, f, g)
    D = copy(adjacency_matrix)

    for k in 1:nodes
        d = copy(D)  # fill(Inf,n,n) # n*n matrise hvor alle har verdien Inf
        for i in 1:nodes
            for j in 1:nodes
               d[i,j] = f(D[i,j], g(D[i,k], D[k,j]))
            end
        end

        D = d
    end
    
    return D
end


# Oppgave 2
function transitive_closure(adjacency_matrix, nodes)
    n = size(adjacency_matrix, 1) # antall rader

    D = floyd_warshall(adjacency_matrix, nodes, min, +)
    TC = zeros(n, n) # n*n matrise med nuller

    for i in 1:n
        for j = 1:n
            if D[i,j] != Inf
                TC[i,j] = 1
            end
        end
    end

    return TC
end


# Oppgave 3
function create_preference_matrix(ballots, voters, candidates)
    # P[a,b] er hvor mange ganger kandidat a er listet over kandidat b
    # Kandidatene har navn "A", "B", ... , "Z" i index 1, 2, ... , 26
    # index utregning: name - 'A' + 1

    # Pseudokode: 
    # Initialiser P
    # Gå gjennom alle voters
        # gå gjennom med i fra 1 til candidates-1
            # gå gjennom med j fra i+1 til candidates
                # P[i, j] ++
    # returner P

    P = zeros(candidates, candidates)

    for v in 1:voters
        ballot = ballots[v]
        for i in 1:candidates-1
            indx_a = ballot[i] - 'A' + 1
            for j in i+1:candidates
                indx_b = ballot[j] - 'A' + 1

                P[indx_a, indx_b] += 1
            end
        end
    end

    return P
end


# Oppgave 4
function find_strongest_paths(preference_matrix, candidates)
    # Todelt algoritme

    # Start med å sette de svakeste mellom hvert par til 0

    # Så skal vi bruke floyd warshall fra oppgave 1
    # f og g skal være max og min for da finner den største minste
    # sti som det spørres etter


    P = copy(preference_matrix)

    for i in 1:candidates
        for j in 1:candidates
            if P[i,j] < P[j,i]
                P[i,j] = 0
            else
                P[j,i] = 0
            end
        end
    end

    return floyd_warshall(P, candidates, max, min)

end


# Oppgave 5
function find_schulze_ranking(strongest_paths, candidates)
    S = strongest_paths

    # initialiserer indexen til bokstavene med 0
    L = Array{Union{Nothing, Tuple{Char, Int}}}(nothing, candidates, 1)
    for i in 1:candidates
        # vet at    : indx = name - 'A' + 1
        # derfor må : name = indx + 'A' - 1
        name = i + 'A' - 1
        L[i] = (name, 0)
    end

    # finner ut av hvor mange de vinner, som blir rangen til bokstavene
    for i in 1:candidates-1
        for j in i+1:candidates
            if S[i,j] > S[j,i]
                L[i] = (L[i][1], L[i][2] + 1)
            else
                L[j] = (L[j][1], L[j][2] + 1) 
            end
        end
    end
    # L er nå en liste med ("A", rangen til "A"), ("B", rangen til "B"), osv...

    # Sorterer L etter rangen dens, størst rang først, over den ene dimensjonen vår
    L = sort(L, by=x->x[2], rev=true, dims=1)

    # ret er bokstavene inni L
    ret = [x[1] for x in L]

    # returner arrayen med characters som en streng
    return join(ret)
end

# Eksempel på find_schulze_ranking:

# S = [ 0 20 20 17;
#      19  0 19 17; 
#      19 21  0 17; 
#      18 18 18 0]

# L = [0,0,0,0]

# S[1,2] = 20 > S[2,1] = 19 => L[1] = 1, L[2] = 0, L[3] = 0, L[4] = 0
# S[1,3] = 20 > S[3,1] = 19 => L[1] = 2, L[2] = 0, L[3] = 0, L[4] = 0
# S[1,4] = 17 < S[4,1] = 18 => L[1] = 2, L[2] = 0, L[3] = 0, L[4] = 1

# S[2,3] = 19 < S[3,2] = 21 => L[1] = 2, L[2] = 0, L[3] = 1, L[4] = 1
# S[2,4] = 17 < S[4,2] = 18 => L[1] = 2, L[2] = 0, L[3] = 1, L[4] = 2

# S[3,4] = 17 < S[4,3] = 18 => L[1] = 2, L[2] = 0, L[3] = 1, L[4] = 3

# => L[4], L[1], L[3], L[2] 
# => "DACB"