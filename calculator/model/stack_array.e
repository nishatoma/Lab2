note
	description: "[
		STACK_ARRAY inherits complete contracts from ABTSRACT_STACK
		implemented with an ARRAY testable via ES_TEST
		  implementation: ARRAY [G]
		top of the stack is last element of the array
		
		TBD marks the places to be done
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STACK_ARRAY [G -> attached ANY]

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

feature {NONE, ES_TEST} -- creation

	implementation: ARRAY [G]
			-- implementation of stack as array

	make
			-- create an empty stack
		do
			create implementation.make_empty -- Initialize an empty array
			implementation.compare_objects -- Enable object comparison
		end

feature -- model

	model: SEQ [G]
			-- abstraction function to model our STACK_ARRAY
		do
			create Result.make_empty
				-- TBD
			across
				implementation as cursor
			loop
				Result.prepend (cursor.item)
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
				--TBD
			Result := implementation [implementation.count]
				-- the above may be super CORRECT BOIZ
		ensure then
			stack_unchanged: model ~ (old model.deep_twin)
		end

feature -- Commands

	push (x: G)
			-- push `x' on to the stack
		do
				-- TBD
			implementation.force (x, implementation.upper + 1)
		end

	pop
		do
				-- TBD
			implementation.remove_tail (1)
		end

invariant
	same_count: model.count = implementation.count
	equality: across implementation.lower |..| count as i all model [i.item] ~ implementation [count + 1 - i.item] end
	comment ("top of stack is model[1] and implementation[count]")
end
