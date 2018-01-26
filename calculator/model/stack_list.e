note
	description: "[
		STACK_LIST inherits complete contracts from ABTSRACT_STACK
		implemented with an ARRAY testable via ES_TEST
		  implementation: LIST [G]
		top of the stack is first element of the list
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STACK_LIST [G -> attached ANY]

inherit

	ANY
		undefine
			is_equal
		end

	ABSTRACT_STACK [G]
		redefine
			count
		end

create
	make

feature {ES_TEST} -- creation

	implementation: LINKED_LIST [G]
			-- implementation of stack as array

	make
			-- create an empty stack
		do
			create implementation.make
			implementation.compare_objects
		end

feature -- model

	model: SEQ [G]
			-- abstraction function
		do
			create Result.make_empty
				-- TBD
			across
				implementation as cursor
			loop
				Result.append (cursor.item)
			end
		end

feature -- Queries

	count: INTEGER
			-- number of items in stack
		do
				-- TBD
			Result := implementation.count
		ensure then
			stack_unchanged: model ~ (old model.deep_twin)
		end

	top: G
		do
			Result := implementation [implementation.lower]
				-- the above may be correct BOIZ
				-- TBD
		ensure then
			stack_unchanged: model ~ (old model.deep_twin)
		end

feature -- Commands

	push (x: G)
			-- push `x' on to the stack
		do
				-- TBD
			implementation.put_front (x)
		end

	pop
		do
				-- TBD
			implementation.go_i_th (implementation.lower) -- go_i_th to lower is equivalent to implementation.start
				-- implementation.start
			implementation.remove
		end

invariant
	same_count: model.count = implementation.count
	equality: across implementation.lower |..| count as i all model [i.item] ~ implementation [i.item] end
	comment ("top of stack is model[1] and implementation[1]")

end
