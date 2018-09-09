# Basert på pseudokode fra forelesning
function partition!(A, p, r)
	x = A[r]	# siste element i partisjonen
	i = p-1		# indexen før p

	# gå gjennom partisjonen
	for j in p:(r-1)
	    if A[j] <= x
	        i += 1
	        tmp = A[i]
	        A[i] = A[j]
	        A[j] = tmp
	    end
	end
	tmp = A[r]
	A[r] = A[i+1]
	A[i+1] = tmp
	return i+1
end

# Basert på pseudokode fra forelesning
function quick_sort!(A, p, r)
    if p < r
        q = partition!(A, p, r)
        quick_sort!(A, p, q-1)
        quick_sort!(A, q+1, r)
    end
    return A
end

# Kaller quick_sort på riktig måte
function algdat_sort!(A)
    return quick_sort!(A, 1, length(A))
end


# Binærsøkfunksjonene fra del a)
function bisect_left(A, p, r, v)
    i = p
    if p < r
        q = floor(Int, (p+r)/2)
        if v <= A[q]
            i = bisect_left(A, p, q, v)
        else
            i = bisect_left(A, q+1, r, v)
        end
    end
    return i
end

function bisect_right(A, p, r, v)
    i = p
    if p < r
        q = floor(Int, (p+r)/2)
        if v < A[q]
            i = bisect_right(A, p, q, v)
       	else
            i = bisect_right(A, q+1, r, v)
        end
    end
    return i
end


function find_median(A, lower, upper)
    # Finn indexen til lower og upper
    min_index = bisect_left(A, 1, length(A)+1, lower)
    max_index = bisect_right(A, 1, length(A)+1, upper) - 1

    # finner median
    if (max_index-min_index+1)%2 == 0
        # hvis partall, returner gjennomsnitt av de to i midten
        i = floor(Int, (max_index-min_index)/2) 
        i += min_index
        return (A[i] + A[i+1])/2
    else
        # hvis oddetall, returner den i midten
        return A[min_index + floor(Int, (max_index - min_index)/2)]
    end
end
