# RULES DEFINITION
# ------------------
# The following defines the inference rules of
# sequent calculus which applies to propositional logic
#
# see: http://en.wikipedia.org/wiki/Sequent_calculus#Inference_rules

module Rules

	# tactics, i.e application order of rules.
	def self.apply(sequent)
		axiomrule(sequent) + 
		leftconjrule(sequent) + 
		rightconjrule(sequent) + 
		leftdisjrule(sequent) +
		rightdisjrule(sequent) +
		leftimplrule(sequent) +
		rightimplrule(sequent)
	end

	def self.axiomrule(sequent)
		judgement = sequent.judgement
		if (judgement.is_a? Implication and 
		    judgement.leftprop.is_a? Falsity and 
		    judgement.rightprop.is_a? Falsity)
		    [[[], :axiom]]
		elsif (judgement.is_a? Atom and sequent.prop_list.include? judgement)
			[[[], :axiom]]
		elsif not sequent.prop_list.select {|x| x.is_a? Falsity}.empty?
			[[[], :axiom]]
		else
			[]
		end
	end
	
	def self.rightimplrule(sequent)
		judgement = sequent.judgement
		if (judgement.is_a? Implication)
			newprop_list = sequent.prop_list + [judgement.leftprop]
			newjudgement = judgement.rightprop
			return [[[Sequent.new(newprop_list, newjudgement)], :rightimplrule]]
		else
			return []
		end
	end	

	def self.leftimplrule(sequent)
		seq_list = []
		sequent.prop_list.each do |prop|	
			if (prop.is_a? Implication)
				p = prop.leftprop
				q = prop.rightprop
				altered_prop_list = sequent.prop_list - [prop]			
				new_seq = [Sequent.new(sequent.prop_list, p), 
						   Sequent.new([q] + altered_prop_list, sequent.judgement)]								
				seq_list << [new_seq, :leftimplrule]
			end
		end
		seq_list
	end
	
	def self.rightconjrule(sequent)
		judgement = sequent.judgement
		if ( judgement.is_a? Implication and 
				  judgement.rightprop.is_a? Falsity and
				  judgement.leftprop.is_a? Implication and
				  judgement.leftprop.rightprop.is_a? Implication and
				  judgement.leftprop.rightprop.rightprop.is_a? Falsity)
			p = judgement.leftprop.leftprop
			q = judgement.leftprop.rightprop.leftprop
			return [[[Sequent.new(sequent.prop_list, p)], :rightconj], 
					[[Sequent.new(sequent.prop_list, q)], :rightconj]]
		 else
		 	return []
		 end
	end
	
	def self.leftconjrule(sequent) 
		seq_list = []
		sequent.prop_list.each do |prop|
			if (prop.is_a? Implication and
				prop.rightprop.is_a? Falsity and
				prop.leftprop.is_a? Implication and
				prop.leftprop.rightprop.is_a? Implication and
				prop.leftprop.rightprop.rightprop.is_a? Falsity)
				p = prop.leftprop.leftprop
				q = prop.leftprop.rightprop.leftprop
				altered_prop_list = sequent.prop_list - [prop]
				seq_list = seq_list + [[Sequent.new([p]+[q]+altered_prop_list, 
				                          sequent.judgement)], :leftconj]
			end
		end
		seq_list
	end
	
	def self.rightdisjrule(sequent) 
		if (sequent.judgement.is_a? Implication and
				  sequent.judgement.leftprop.is_a? Implication and
				  sequent.judgement.leftprop.rightprop.is_a? Falsity)
			q = sequent.judgement.rightprop
			p = sequent.judgement.leftprop.leftprop
			return [[[Sequent.new(sequent.prop_list, p)], :rightdisjrule], 
			        [[Sequent.new(sequent.prop_list, q)], :rightdisjrule]]
		else
			return []
		end
	end
	
	def self.leftdisjrule(sequent)
		seq_list = []
		sequent.prop_list.each do |prop|
			if (prop.is_a? Implication and 
				prop.leftprop.is_a? Implication and
				prop.leftprop.rightprop.is_a? Falsity)
				p = prop.leftprop.leftprop
				q = prop.rightprop
				newseq = [Sequent.new([p]+sequent.prop_list, sequent.judgement), 
				          Sequent.new([q]+sequent.prop_list, sequent.judgement)]
				seq_list << [newseq, :leftdisjrule]
			end
		end
		seq_list
	end
end