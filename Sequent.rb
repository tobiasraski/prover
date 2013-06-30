# SEQUENT DEFINITIONS
# ------------------------
# A sequent is a list of propisitions (premises) and
# a judgement (also a proposition)

class Sequent 
	def initialize(prop_list, judgement)
		@prop_list = prop_list
		@judgement = judgement
	end
	
	def judgement
		@judgement
	end
	
	def prop_list
		@prop_list
	end
	
	def to_s
		str = ""
		@prop_list.each do |prop|
			str = str + prop.to_s + ", "
		end
		str = str + "|- " + @judgement.to_s
	end
end