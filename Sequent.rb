# SEQUENT DEFINITIONS
# ------------------------
# A sequent (judgment) is a list of propositions (premises) and
# a conclusion (also a proposition)

class Sequent 
	def initialize(prop_list, conclusion)
		@prop_list = prop_list
		@conclusion = conclusion
	end
	
	def conclusion
		@conclusion
	end
	
	def prop_list
		@prop_list
	end
	
	def to_s
		str = ""
		@prop_list.each do |prop|
			str = str + prop.to_s + ", "
		end
		str = str + "|- " + @conclusion.to_s
	end
end