# PROOF DEFINITION
# ------------------
# A proof is a sequent, an inference rule and a list
# of subproofs that the inference rule depends on.

class Proof
	def initialize(sequent, rule, subproofs)
		@sequent = sequent
		@rule = rule
		@subproofs = subproofs
	end
	
	def to_s
		printprooftree(1)
	end
	
	def printprooftree(depth)
		str = ""
		depth.times {str << "\t"}
		str << "proof of " + @sequent.to_s + " " +
		"use rule " + @rule.to_s + "\n" 
		return str if @subproofs.nil?
		@subproofs.each do |proof|
			str = str + proof.printprooftree(depth+1)
		end
		str
	end
end
