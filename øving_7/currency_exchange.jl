# Oppgave 1
function can_use_greedy(coins)
    # for alle Ci element i C skal (Ci/(Ci+1)) være heltall
    for c in 2:length(coins)
        if coins[c-1]%coins[c]!=0
            return false
        end
    end
    return true
end

# Oppgave 2
function min_coins_greedy(coins, value)
    # starter med å sjekke de største myntverdiene
    index = 1
    antall = 0
    while value > 0
        if coins[index] > value
            index += 1
        else
        	value -= coins[index]
        	antall += 1
        end
    end
    return antall
end

# Oppgave 3
function min_coins_dynamic(coins,value)
    c = [1]	# hvor mange mynter vi bruker

    for i in 2:value
    	# hvor mange mynter vi bruker ved å bruke hver mynttype
    	# på denne verdien av i
        posibilities = []

        # går gjennom listen med mynter baklengs
        for j in length(coins):-1:1

        	# hvis mynten er mindre enn i, trekk fra i og legg til bruk 
        	# antall mynter for den verdien pluss den ene mynten du la til å
            if coins[j] < i
                push!(posibilities, c[i-coins[j]] + 1)


            # hvis mynten er like stor som i, så trenger vi kun denne ene mynten
            elseif coins[j] == i
            	push!(posibilities, 1)

           	# ellers så trenger vi ikke sjekke den neste myntene for de
           	# er for store
            else
            	break
            end
        end

        # nå vlger vi den muligheten som gir minst mynter for verdien i
        push!(c, minimum(posibilities))
    end

    return c[end]
end

