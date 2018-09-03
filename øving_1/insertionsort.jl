function insertionsort!(list)
	for i in 2:length(list)
		j = i
		while j > 1 && list[j-1] > list[j]
			tmp = list[j]
			list[j] = list[j-1]
			list[j-1] = tmp
			j -= 1
		end
	end
end

insertionsort!([1,3,12,5,4,3])

