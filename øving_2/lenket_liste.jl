mutable struct Record
	next::Union{Record,Nothing}  # next kan peke på et Record-objekt eller ha verdien nothing.
	value::Int
end

function createlinkedlist(length, valuerange)
	# Lager listen bakfra.
	next = nothing
	record = nothing
	for i in 1:length
		record = Record(next, rand(valuerange))  # valuerange kan f.eks. være 1:1000.
		next = record
	end
	return record
end

function traversemax(head)
	max_value = head.value
	current = head
	while current.next != nothing
		current = current.next
		if current.value > max_value
			max_value = current.value
		end
	end
	return max_value
end