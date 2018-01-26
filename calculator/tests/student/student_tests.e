note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit

	ES_TEST

create
	make

feature {NONE} -- make

	make
		do
			add_boolean_case (agent t0)
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
			add_violation_case_with_tag ("valid_expression", agent t11)
		end

feature -- Test agents

	t0: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
			v: REAL
		do
			comment ("t0: Testing evaluated " + "<br/>")
			create e.make ("list") -- array implementation
			exp := "(5 + 5)"
			v := e.evaluated (exp)
			Result := v = 10
			check
				Result
			end
		end

	t1: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment ("t1: Evaluate (16.2 +4.1*2.4)")
			l_exp := "(16.2 +4.1*2.4)"
			create e.make ("array")
			e.evaluate (l_exp)
			Result := e.value ~ 26.04 and not e.error
			check
				Result
			end
			Result := (-4.71 <= e.evaluated ("-7.8 + 3.1")) and e.evaluated ("-7.8 + 3.1") <= 4.7
		end

	t2: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t2: Evaluate (6000/0) division by zero and error checking. " + "<br/>")
			sub_comment ("Also tests other expressions.")
			create e.make ("array") -- array type
			exp := "(6000/0)"
			e.evaluate (exp)
			Result := e.value.out ~ "Infinity" and then not e.error
			check
				Result
			end
			create e.make ("list") -- this time with list!
			e.evaluate (exp)
			Result := e.value.out ~ "Infinity" and then not e.error
			check
				Result
			end
			exp := "(500)*(3-5000)-(400+4)+(100/100)"
			e.evaluate (exp)
			Result := e.value = ((500) * (3 - 5000) - (400 + 4) + (100 / 100)) and then not e.error
			check
				Result
			end
			create e.make ("array")
			e.evaluate (exp)
			Result := e.value = ((500) * (3 - 5000) - (400 + 4) + (100 / 100)) and then not e.error
			check
				Result
			end
		end

	t3: BOOLEAN
		local
			s: STACK_LIST [STRING]
		do
			comment ("t3: Test STACK_LIST Amanda | Vlad | Adrian ")
			create s.make
			s.push ("Amanda")
			s.push ("Vlad")
			s.push ("Adrian")
			Result := s.top ~ "Adrian"
			check
				Result
			end
			Result := s.count = 3
			check
				Result
			end
			s.pop
			Result := s.top ~ "Vlad" and then s.count = 2
			check
				Result
			end
			s.pop
			Result := s.top ~ "Amanda" and then s.count = 1
			check
				Result
			end
			s.pop
			Result := s.count = 0
			check
				REsult
			end
		end

	t4: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t4: Evaluate ((450 - 5 + 10 * 30) / (3 / 5 + 10 * 2)) ")
			create e.make ("array")
			exp := "((450 - 5 + 10 * 30) / (3 / 5 + 10 * 2))"
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000001 and then not e.error
			check Result end
			Result := -4.7 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.5
			check Result end
			create e.make ("list")
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000000001 and then not e.error
			check Result end
			Result := -4.600000000001 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.599999999999
		end

	t5: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t5: Evaluate ((5 / 6 / 7 / 8) / (9 / 10 / 11 / 12)) ")
			create e.make ("array")
			exp := "((5 / 6 / 7 / 8) / (9 / 10 / 11 / 12))"
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000001 and then not e.error
			check Result end
			Result := -4.7 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.5
			check Result end
			create e.make ("list")
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000000001 and then not e.error
			check Result end
			Result := -4.600000000001 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.599999999999
		end

	t6: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t6: Evaluate ((-5 / 6 / -7 / 8) / (9 / -10 / -11 / -12)*30) ")
			create e.make ("array")
			exp := "((-5 / 6 / -7 / 8) / (9 / -10 / -11 / -12)*30)"
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000001 and then not e.error
			check Result end
			Result := -4.7 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.5
			check Result end
			create e.make ("list")
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000000001 and then not e.error
			check Result end
			Result := -4.600000000001 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.599999999999
		end

	t7: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t7: Evaluate ((3/3/5/6/7/8/9) * (340/350/360 - 3500/4500) - 1000)  ")
			create e.make ("array")
			exp := "((3/3/5/6/7/8/9) * (340/350/360 - 3500/4500) - 1000)"
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000001 and then not e.error
			check Result end
			Result := -4.7 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.5
			check Result end
			create e.make ("list")
			e.evaluate (exp)
			Result := (e.value - e.evaluated (exp)).abs <= 0.000000000001 and then not e.error
			check Result end
			Result := -4.6000000000000001 <= e.evaluated ("-4.6") and then e.evaluated ("-4.6") <= -4.599999999999
		end
	t8: BOOLEAN
		local
			e: EVALUATOR
			exp: STRING
		do
			comment ("t8: Evaluate (6+(7-(3*(2*(5/(3/(2/(5*(150*(-3.4*(5-7)*-3/150)*2)*2)*2)*-3.4/5.9)+10)-19)-2.435)+3)+3) ")
			create e.make ("list")
			exp := "(6+(7-(3*(2*(5/(3/(2/(5*(150*(-3.4*(5-7)*-3/150)*2)*2)*2)*-3.4/5.9)+10)-19)-2.435)+3)+3)"
			e.evaluate (exp)
			Result := (e.value - (6+(7-(3*(2*(5/(3/(2/(5*(150*(-3.4*(5-7)*-3/150)*2)*2)*2)*-3.4/5.9)+10)-19)-2.435)+3)+3)).abs <= 0.00001 and then not e.error
			check Result end
			create e.make ("array")
			e.evaluate (exp)
			Result := (e.value - (6+(7-(3*(2*(5/(3/(2/(5*(150*(-3.4*(5-7)*-3/150)*2)*2)*2)*-3.4/5.9)+10)-19)-2.435)+3)+3)).abs <= 0.00001 and then not e.error
			check Result end
			create e.make ("list")
			e.evaluate ("5-5+5-5+3")
			Result := e.value = e.evaluated ("5-5+5 -5 + 3") and then not e.error
			check Result end
			exp := "(-15.5-156-7+0-3.4444444444444444444444444)"
			e.evaluate (exp)
			Result := ((-15.5-156-7+0-3.4444444444444444444444444) - e.value).abs <= 0.00001 and then not e.error
			check Result end
			create e.make ("array")
			e.evaluate (exp)
			Result := ((-15.5-156-7+0-3.4444444444444444444444444) - e.value).abs <= 0.00001 and then not e.error
			check Result end
		end

	t9: BOOLEAN
		local
			l1: STACK_LIST [STRING]
			l2: STACK_LIST [STRING]
			str: STRING
		do
			comment("t9: Compare lists as stacks")
			create l1.make
			create l2.make
			str := "Amanda"
			l1.push (str)
			l2.push (str)
			str := "Vlad"
			l1.push (str)
			l2.push (str)
			Result := l1 ~ l2
			check Result end
			Result := l1.top ~ l2.top and then l1.count = l2.count and then l1.model ~ l2.model
			check Result end
			create l1.make
			create l2.make
			Result := l1.model.count = 0 and then l1.model.count = l2.model.count
			check Result end
		end

	t10: BOOLEAN
		local
			l1: STACK_ARRAY [STRING]
			l2: STACK_ARRAY [STRING]
			str: STRING
		do
			comment("t10: Compare arrays as stacks")
			create l1.make
			create l2.make
			str := "Amanda"
			l1.push (str)
			l2.push (str)
			str := "Vlad"
			l1.push (str)
			l2.push (str)
			Result := l1 ~ l2
			check Result end
			Result := l1.top ~ l2.top and then l1.count = l2.count and then l2.model ~ l1.model
			check Result end
			Result := l1.model.upper = l2.model.upper
			check Result end
		end


	t11
		local
			e: EVALUATOR
			exp: STRING
		do
			comment("t11v: Evaluate (((((((((()))))))))) ")
			create e.make ("array")
			exp := "(((((((((())))))))))"
			e.evaluate (exp)
		end



end
