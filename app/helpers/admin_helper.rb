module AdminHelper
	def find_usertype(e)
		if     e.is_developer? 
			@utype= "Developer"
		elsif  e.is_tester?
			@utype= "Tester"
		else
		end		
	end

	def find_tlead(u)
		@tl=Teamlead.find(u.teamlead_id).username	
	end
end
