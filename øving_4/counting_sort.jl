# Oppgave 1
function counting_sort_letters(A, position)
    # 'a' starter på 97, så vi må trekke fra 96 plasser fra alle 
    # bokstavene når vi gjør dem om til tallfor å kunne 
    # plassere de riktig
    start = Int('a') - 1

    # Lager en liste med 26 nuller, en for hver bokstav i alfabetet
    C = fill(0, 26)

    # Initialiserer listen som skal returneres
    B = fill("", length(A))

    # Teller opp hvor mange av de forskjellige bokstavene vi har
    for i in 1:length(A)
    	pos = Int(A[i][position]) - start
        C[pos] += 1
    end

    # Gjør om c til å ha med antall i plassen før seg
    for i in 2:26
        C[i] += C[i-1]
    end

    # Samler sortetringen og setter den inn i B 
    for i in length(A):-1:1
    	pos = Int(A[i][position]) - start
        B[C[pos]] = A[i]
        C[pos] -= 1
    end

    return B
end

# Oppgave 2
function counting_sort_length(A)
    # Finn ut hvor lang den lengste strengen er
    # +1 fordi vi kan komme over strenger som er 0 lengde
    longest = findmax(length.(A))[1] + 1

    B = fill("", length(A))
    C = fill(0, longest)

    for i in 1:length(A)
        C[length(A[i]) + 1] += 1
    end

    for i in 2:longest
        C[i] += C[i-1]
    end

    for i in length(A):-1:1
    	B[C[length(A[i]) + 1]] = A[i]
    	C[length(A[i]) + 1] -= 1
    end

    return B
end


