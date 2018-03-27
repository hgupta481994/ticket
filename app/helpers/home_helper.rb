module HomeHelper
	def find_tlead(u)
		@tl=Teamlead.find(u.teamlead_id).username	
	end

	def find_task_type(t)
		if t.of_issue? 
			@type= "Issue"
	    elsif t.of_change_request? 	    		
	    	@type= "Change Request"
	    else 
	    	@type= "Enhancement"
	    end 
	end

	def find_project(t)
		@rq=Requirement.find(t.requirement_id).name
	end

	def find_status(t)
		if(t.status_id==nil)
	    	@status= "Created"
    	elsif(t.assigned?)
    		@status= "Assigned"
    	elsif(t.marked?) 
    		@status= "Marked"
		elsif(t.on_review?)
    		@status= "On-Review"
    	elsif(t.reviewed?) 
    		@status= "Reviewed"
    	elsif(t.closed?) 
    		@status= "Closed"
    	elsif(t.reopened?) 
    		@status= "Reopened"
    	end
	end
end
