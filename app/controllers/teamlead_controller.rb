class TeamleadController < ApplicationController

	def make_task_tl
		authorize! :read, User
		@rq = Requirement.find(params[:id])
		@tks= Task.where(:requirement_id => params[:id])
		@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id)
		@tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id)
		
		@assin_users = User.where("teamlead_id = ? and (usertype_id = 4 or usertype_id = 3)", Teamlead.find_by_username(current_user.username).id)
		 
	end

	def tl_assign_to_multiple
		@rq = Requirement.find(params[:id])
		if(params[:developer] != "" and params[:tester] != "")
			
			flash[:notice] =  "You cannot select both developer and tester "
			redirect_to make_task_tl_path(@rq.id)

		else
			if (params[:developer] != "" && params[:tasks_ids] != nil)
							
				Task.where(id: params[:tasks_ids]).update_all user_id:   params[:developer]
				Task.where(id: params[:tasks_ids]).update_all status_id: 1
	    		redirect_to make_task_tl_path(@rq.id)
	    	elsif(params[:tester] != "" && params[:tasks_ids] != nil)
	    		Task.where(id: params[:tasks_ids]).update_all user_id: params[:tester]
	    		Task.where(id: params[:tasks_ids]).update_all status_id: 3
	    		redirect_to make_task_tl_path(@rq.id)
			else 
				flash[:notice] =  "You Didn't selected any user or task"
				redirect_to make_task_tl_path(@rq.id)
			end
		end
	end

	def tl_assign
		@rq = Requirement.find(params[:rid])
		if(params[:developer] != nil and params[:tester] != nil)
			
			flash[:notice] =  "You cannot select both developer and tester "
			redirect_to make_task_tl_path(@rq.id)

		else
			if (params[:developer] != nil )
							
				Task.where(id: params[:tid]).update_all user_id:   params[:developer]
				Task.where(id: params[:tid]).update_all status_id: 1
	    		redirect_to make_task_tl_path(@rq.id)
	    	elsif(params[:tester] != nil )
	    		Task.where(id: params[:tid]).update_all user_id: params[:tester]
	    		Task.where(id: params[:tid]).update_all status_id: 3
	    		redirect_to make_task_tl_path(@rq.id)
			else 
				flash[:notice] =  "You Didn't selected any user or task"
				redirect_to make_task_tl_path(@rq.id)
			end
		end
	end

	def add_task
		authorize! :create, Task
		@rq  = Requirement.find(params[:id]) 
		@emp = User.where("teamlead_id = ?", current_user.id)
		@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id)
		@tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id)
		#@user = User.where(:teamlead_id => @emp.id)
		@task= Task.new
	end

	def developer
		@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id)
	end

	def tester
		@tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id)
	end


	
	private 
    def task_params 
    	 params.require(:task).permit(:name,:description,:avatar,:end, :teamlead_id,:start, :type_id, :requirement_id ) 
  	end
end
