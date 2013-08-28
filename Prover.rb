require_relative 'propositions'
require_relative 'rules'
require_relative 'sequent'
require_relative 'proof'

# SEQUENT CALCULUS PROVER FOR PROPOSITIONAL LOGIC
# -------------------------------------------------
# (http://en.wikipedia.org/wiki/Sequent_calculus)
#
#
# Give the program a sequent of the form 
#
# proposition, proposition, ... : proposition
#
# and it will try to prove that the proposition to the right of ":"
# follows from the left hand propositions using the inference rules
# of sequent calculus.
#
# The propositions should be put in using reverse polish notation, e.g
# a b ->
# for "a implies b"
# 
# Propositions can be built from atoms (e.g a, b, p, q, ...), implication ( -> )
# and Falsity (F).
# The other binary operators can be built using these. e.g
#
# "a F -> F -> b ->"  is the same as "a or b"


# PROVER
# -------
# Takes a sequence and a max depth (max depth of the proof tree)

class Prover 	
	def prove(sequent, depth)
		#puts sequent
		if depth <= 0
			return nil
		end
		subgoals_rule_pairs = Rules.apply(sequent)
		subgoals_rule_pairs.select! {|pair| not pair.empty?}
		if (subgoals_rule_pairs.include? [[],:axiom])
			return Proof.new(sequent, :axiom, nil)
		end
		proofs = []
		subgoals_rule_pairs.each do |pair|
			subgoals = pair[0]
			rule = pair[1]
			subproofs = []
			subgoals.each do |goal|
				subproof = prove(goal, depth-1)
				unless subproof.nil?
					subproofs = subproofs + [subproof]
				end
			end
			if (not subproofs.empty?)	
				proofs = proofs + [Proof.new(sequent, rule, subproofs)]		
			end
		end
		
		if (not proofs.empty?)
			return proofs.first
		else
			return nil
		end
		
	end
end

# Helper function for parsing.
def createfromstring(input)
    	stack = []
    	input.lstrip!
    	while input.length > 0
    		case input
    		when /\A-?F/
        		stack.push(Falsity.new)
        	when /\A-?\w+/
        		stack.push(Atom.new($&))
        	when /\A-?->/
				raise 'Error in parse' if stack.size < 2
          		right_operand = stack.pop()
          		left_operand = stack.pop()
	 
    	      	stack.push(Implication.new(left_operand, right_operand))
			end
			input = $'
			input.lstrip!
    	end
    	raise 'Error in parse' if stack.size != 1 
    	stack.pop()
end



# START OF PROGRAM
# ------------------
# Comment/uncomment to get desired input

#seq = "a b ->, a : b"         # a -> b, a : b 
#seq = " : a F -> F -> a ->"  #  : ((a -> F) -> F) -> a, the same as (not a) or a
seq = "a b ->, b c a -> -> , a : c a ->"
#seq = " b : a F -> F -> b ->"
#seq = gets

conclusion = createfromstring(seq.split(":")[1])
seq_strings = seq.split(":")[0].strip
if (seq_strings == "")
	prop_list = []
else
	prop_list = seq_strings.split(",").collect {|prop| createfromstring(prop)}
end
sequent = Sequent.new(prop_list, conclusion)
allowed_depth = 12
prover = Prover.new
puts "Trying to prove " + sequent.to_s
puts "---------------------------"
puts ""
puts prover.prove(sequent, allowed_depth)