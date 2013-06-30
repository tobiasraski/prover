# PROPOSITION DEFINITIONS
# ------------------------
# The following defines three types of
# propositions - Implication, Atom, Falsity.
# TODO: Add disjunction, conjunction etc.


class Implication
    
    attr_accessor :leftprop
    attr_accessor :rightprop
    
	def initialize(leftprop, rightprop)
		@leftprop = leftprop
		@rightprop = rightprop
	end
	
	def to_s
		"("+leftprop.to_s + '->' + rightprop.to_s+")"
	end
	
	def ==(prop) 
		prop.is_a? Implication and
		@leftprop == prop.leftprop and
		@rightprop == prop.rightprop
	end
end

class Atom

    attr_accessor :name
    
	def initialize(name)
		@name = name
	end
	
	def to_s
		@name.to_s
	end
	
	def ==(prop) 
		prop.is_a? Atom and @name == prop.name
	end
end

class Falsity
	def to_s
		return 'F'
	end
	
	def ==(prop) 
		prop.is_a? Falsity
	end
end

