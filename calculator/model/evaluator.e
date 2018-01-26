note
	description: "[
		Evaluator for arithmetic expressions involving
		+, -, *, / in REAL_32 arithmetic
		Use Dijsktra's two stack algorithm
		https://algs4.cs.princeton.edu/13stacks/Evaluate.java.html
		
		TBD -- features marked with this are To Be Done
	]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	EVALUATOR

create
	make

feature {NONE} -- Constructor

	make (stack_type: STRING)
			-- initialize
		require
			stack_type ~ "array" OR stack_type ~ "list"
		do
			if stack_type ~ "array" then
				create {STACK_ARRAY [STRING]} ops.make
				create {STACK_ARRAY [REAL]} vals.make
			else
				check
					stack_type ~ "list"
				end
				create {STACK_LIST [STRING]} ops.make
				create {STACK_LIST [REAL]} vals.make
			end
			error := True
			expression := "None"
		end

feature -- Queries

	ops: ABSTRACT_STACK [STRING]
			-- operations stack

	vals: ABSTRACT_STACK [REAL]
			-- values stack

	expression: STRING
			-- string espression to be evaluated

	value: REAL
			-- value if no error
		require
			not error
		attribute
		end

	error: BOOLEAN
			-- Is there a syntax error in `expression'

	error_string (s: STRING): STRING
			-- Error message if any
		local
			tokenizer: TOKENIZER
		do
			create tokenizer.make
			Result := tokenizer.error_string (s)
		end

	is_valid (s: STRING): BOOLEAN
			-- Is string `s' a valid arithmetic expression?
		local
			tokenizer: TOKENIZER
		do
			create tokenizer.make
			Result := tokenizer.is_arithmetic_expression (s)
		end

	evaluated (s: STRING): REAL
			-- Evaluated arithmetic expression `s'
		require
				--TBD missing precondition
				--Precondition just checks if the `s' is a valid expression.
			valid_expression: not s.is_empty and then is_valid (s)
		local
			tokenizer: TOKENIZER
			op_stack: STACK_LIST [STRING]
			val_stack: STACK_LIST [REAL]
		do
				-- TBD
			create tokenizer.make
			create {STACK_LIST [STRING]} op_stack.make
			create {STACK_LIST [REAL]} val_stack.make
			-- Evaluate using eval
			Result := eval (s, val_stack, op_stack)
		ensure
			-- This is a query, so make sure nothing has changed.
			value_unchanged: value = old value -- value stays the same
			error_unchanged: error = old error -- error stays the same
			ops_unchanged: ops ~ (old ops.deep_twin) -- ops stays the same
			vals_unchanged: vals ~ (old vals.deep_twin) -- vals stays the same
			expression_unchanged: expression ~ (old deep_twin).expression -- expression stays the same
		end

feature -- Commands

	evaluate (s: STRING)
			-- Evaluate arithmetic expression `s'
		require
				-- TBD proper precondition needed
			valid_expression: not s.is_empty and then is_valid (s)
		local
			tokenizer: TOKENIZER
			val: REAL
		do
				-- TBD
				-- Use Dijsktra's two stack algorithm
			create tokenizer.make
			expression := s
			error := False
			val := eval (s, vals, ops)
			-- change the class' attribute
			value := val
		ensure
			value_set: value = vals.top
			s_unchanged: s ~ (old s.deep_twin)
			expression_same: expression ~ s
			error_set_false: not error
			expression_still_valid: is_valid (s)
		end

feature {NONE} -- implementation
	-- put your implementation features here
	-- Helper method for `evaluate' and `evaluated'

	eval (s: STRING; val_stack: ABSTRACT_STACK [REAL]; op_stack: ABSTRACT_STACK [STRING]): REAL
		require
			valid_expression: not s.is_empty and then is_valid (s)
		local
			tokenizer: TOKENIZER
			token: STRING
			arr: ARRAY [STRING]
			i: INTEGER
			val: REAL
			op: STRING
		do
			create tokenizer.make
			arr := tokenizer.get_tokens (s)
			from
				i := arr.lower
			until
				i > arr.upper
			loop
				token := arr [i]
				if token ~ "(" then -- do nothing
				elseif token ~ "+" or else token ~ "-" or else token ~ "/" or else token ~ "*" then
					op_stack.push (token)
				elseif token ~ ")" then
					op := op_stack.top
					val := val_stack.top
					op_stack.pop
					val_stack.pop
					if op ~ "+" then
						val := val_stack.top + val
					elseif op ~ "-" then
						val := val_stack.top - val
					elseif op ~ "*" then
						val := val_stack.top * val
					elseif op ~ "/" then
						val := val_stack.top / val
					end
					val_stack.pop -- pop the old value at the end.
					val_stack.push (val) -- then push the latest result.
				else
					val_stack.push (token.to_real)
					val := val_stack.top
				end
				i := i + 1
			end
			Result := val_stack.top
		Ensure
			-- We always pop the operator stack on each iteration, should be empty at the end.
			-- We always keep the value for the operand stack at the end, shoult not be empty.
			stacks_filled: val_stack.count /= 0 and then op_stack.count = 0
			result_proper: Result = val_stack.top
		end

invariant
	consistency1: (expression /~ "None") implies (value = evaluated (expression))
		-- not the other way because?
	consistency2: (expression /~ "None") = (not error)

end
