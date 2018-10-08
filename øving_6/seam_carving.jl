# rows, cols = size(weights)
# elem = weights[row, col]

# Oppgave 1
# Denne koden fikk feil fordi den var for treig, men den bare funket
# etter noen forsøk :)
function cumulative(weights)
    # Får dimensjonene til inputmatrisen
    rows, cols = size(weights)

    # Initialiserer returneringsmatrisen
    path_weights = zeros(Int64, rows, cols)

    # Første rad er alltid samme som inputmatrisen
    path_weights[1,:] = weights[1,:]

    # Gå gjennom matrisen nedover og finn de riktige vektene
    for row in 2:rows
        for col in 1:cols
            # for hvert element, se på de tre over og finn den minste
            above = [path_weights[row-1, col]]

            # kun add den til venstre om den finnes
            if col > 1
                push!(above, path_weights[row-1, col-1])
            end

            # kun add den til høyre om den finnes
            if col < cols
                push!(above, path_weights[row-1, col+1])
            end

            # sett vekten på denne plasseringen
            path_weights[row, col] = weights[row, col] + minimum(above)
        end
    end

    return path_weights
end

# weights = [3  6  8 6 3;
#            7  6  5 7 3;
#            4  10 4 1 6;
#            10 4  3 1 2;
#            6  1  7 3 9]

# println(cumulative(weights))



# Oppgave 2
function back_track(path_weights)
    # Får dimensjonene til inputmatrisen
    rows, cols = size(path_weights)

    # Definerer hvilke colonner vi skal se på
    lower, upper = 2, cols

    # Initialiserer listen med posisjoner fo pathen
    path = []

    # Går oppover i matrisa og finner beste vei
    for row in rows:-1:1

        # Initialiserer minste startverdi og index (elementet nederst til venstre)
        smallest = path_weights[row, lower]
        index = lower

        # Går bortover fra venstre og sjekker de tre elementene over
        # Første runde finner den den minste verdien i den nedesrte raden
        for col in lower:upper
            if path_weights[row, col] < smallest
                smallest = path_weights[row, col]
                index = col
            end
        end

        # Legger til posisjonen til listen
        push!(path, (row, index))

        # Oppdaterer lower og upper
        lower, upper = maximum([0, index-1]), minimum([cols, index+1])
    end

    return path
end








