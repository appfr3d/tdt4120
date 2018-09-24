struct Node
    children::Dict{Char,Node}
    posi::Array{Int}
end

Node() = Node(Dict(),[])

# Oppgave 1
function parse_string(sentence)
    # Skal returnerer en array med touple på formen (ord, index)
    ret = Tuple{String, Int}[]
    lastPos = 1
    for i in 1:length(sentence)
        # Hvis vi ser en space så er et ord ferdig
        if sentence[i] == ' '

            # Legger til ordet, og indexen hvor ordes startet
            push!(ret, (sentence[lastPos:i-1], lastPos))

            # neste ord starter etter mellomrommet
            lastPos = i+1
        end
    end

    # Legg på det siste elementet (antar at scentence 
    # ikke slutter på et mellomrom)
    push!(ret, (sentence[lastPos:end], lastPos))
    return ret
end
# returnerer "en ei et" på formen [("en",1),("ei",4),("et",7)]


# Oppgave 2
function build(list_of_words)
    top_node = Node()
    for word in list_of_words
        add_node!(top_node, word, 1)
    end

    return top_node
end

# Den rekursive funksjonen vi bruker til å løse oppgaven
function add_node!(node, word, pos)
    # husk av word er f.eks. ("en",1) aka word[1] er selve ordet, "en"
    # og word[2] er posisjonen i setningen, 1

    # antar at vi ikke finner en node med bokstaven vi er på i ordet
    node_found = false

    # Hvis det er en child_node med den bokstaven vi leter etter
    child_node = get(node.children, word[1][pos], 0)
    if child_node != 0

        # og vi er på siste plass/index i ordet 
        if pos == length(word[1])

            # så legger vi til startposisjonen til ordet inni denne noden
            push!(child_node.posi, word[2])
            
        # men er vi er inni ordet
        else

            # så sjekker alt på neste bokstav 
            add_node!(child_node, word, pos+1)
        end

        # pass på å si at vi har funnet en node med riktig bokstav,
        # så if-en under ikke kjører!
        node_found = true
    end

    # noden har ikke children med den bokstaven vi ser på, så legg til 
    # noder under for hver bokstav av resten av ordet i rekkefølge
    if !node_found
        current_node = node
        for i in pos:length(word[1])
            new_node = Node()

            # hvis vi er på siste plass i ordet så må vi legge til posisjonen
            if i == length(word[1])
                push!(new_node.posi, word[2])
            end

            current_node.children[word[1][i]] = new_node

            current_node = new_node
        end
    end
end


# Oppgave 3

# I denne oppgaven er word en faktisk streng!
function positions(word,node,index=1)
    # finn alle nodene vi skal starte med å se på
    nodes_to_look_up = [node]
    for i in 1:index-1 
        # index-1 fordi vi vil ikke se på children til "node" om index er 1, 
        # vi vil se på selve noden "node"

        # tmp liste for å holde alle childrene
        new_nodes = []

        # går igjennom alle nodene hittil
        for child in nodes_to_look_up

            # lagrer alle child-nodene
            push!(new_nodes, child[2]) 
        end

        # oppdaterer nodes_to_look_up til å være alle childrene
        nodes_to_look_up = new_nodes
    end

    # gå gjennom nodene vi starter på å sjekk om vi finner ordet
    list_of_positions = []
    for i in 1:length(nodes_to_look_up)
        pos = find_word(word, nodes_to_look_up[i], index)
        if pos != 0
            for n in 1:length(pos)
                push!(list_of_positions, pos[n])
            end
        end
    end

    return list_of_positions
end

function find_word(word, sub_node, index)
    # sjekk om vi er på et ?
    if word[index] == '?'

        # er vi på siste plass i word, returner alle posisjonene som childrene
        # til sub_node har
        if index == length(word)
            positions = []
            for child in sub_node.children
                for i in child[2].posi
                    push!(positions, i)
                end
            end
            return positions

        # ellers så ser vi gjennom alle child-nodene videre
        else 
            positions = []
            for child in sub_node.children

                # samle opp alle posisjonene
                pos = find_word(word, child[2], index+1)

                # kun add hvis det er noen posisjoner lagret der
                if pos != 0
                    for n in 1:length(pos)
                        push!(positions, pos[n])
                    end
                end
            end
            return positions
        end

    # ellers så må vi se inn på verdiene til child-nodene med samme 
    else 
        # ser om vi finner en node med bokstaven
        child_node = get(sub_node.children, word[index], 0)
        
        if child_node == 0
            # ingen childs av sub_node har verdien word[index]
            # returner en 'error'
            return 0 
        elseif index == length(word)
            # returner en listen med posisjoner
            return child_node.posi 
        else
            # kjører et rekursivt kall
            return find_word(word, child_node, index+1)
        end
    end
end

