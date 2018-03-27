module TaskHelper
	def find_task_type(t)
		if t.of_issue? 
			@type= "Issue"
	    elsif t.of_change_request? 	    		
	    	@type= "Change Request"
	    else 
	    	@type= "Enhancement"
	    end 
	end

	def find_user_type(t)
		if t.user_id and User.find(t.user_id).is_developer? 
			@utype= "Developer"
		elsif  t.user_id and User.find(t.user_id).is_tester?
			@utype= "Tester"
		else
		end		
	end

	def find_user(t)
		if t.user_id and (t.user_id != t.teamlead_id)
			@user= User.find(t.user_id).username
		else
			@user= "Not assigned"
		end
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
