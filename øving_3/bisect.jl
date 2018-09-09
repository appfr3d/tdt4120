function bisect_left(A, p, r, v)
    i = p
    if p < r
        # finner midten
        q = floor(Int, (p+r)/2)
        
        # hvis verdien er mindre enn midtverdien
        if v <= A[q]
            # kjør videre på den venstre delen
            i = bisect_left(A, p, q, v)
       	else
            # kjør videre på den høyre delen
            i = bisect_left(A, q+1, r, v)
        end
    end
    return i
end

A = [1,2,3,4,5,6]
print(bisect_left(A, 1, length(A), 5), '\n')

function bisect_right(A, p, r, v)
    i = p
    if p < r
        # finner midten
        q = floor(Int, (p+r)/2)
        
        # hvis verdien er mindre enn midtverdien
        # ikke lengre <= men <
        if v < A[q]
            i = bisect_right(A, p, q, v)
       	else
            i = bisect_right(A, q+1, r, v)
        end
    end
    return i
end

A = [1,2,3,4,5,6]
print(bisect_right(A, 1, length(A), 5), '\n')


