class TeamleadController < ApplicationController
	before_action() { authorize! :access, :teamlead }
	before_action :find_requirement, only: [:make_task_tl, :tl_assign_to_multiple, :tl_assign, :add_task]
	# ********************** Make Task show page ********************
	def make_task_tl
		authorize! :read, User
		@dp_tks = Task.where("requirement_id == ?  and (status_id is null or status_id == 1 or status_id==6)", params[:id]).order("updated_at DESC")
    	@tt_tks = Task.where("requirement_id == ?  and (status_id == 2 or status_id == 3 or status_id == 4 or status_id == 5)", params[:id]).order("updated_at DESC")

		@dps = User.where("teamlead_id = ? and usertype_id = 3", @rq.teamlead_id).order("updated_at DESC")
		@tts = User.where("teamlead_id = ? and usertype_id = 4", @rq.teamlead_id).order("updated_at DESC")	 
	end
	# **********************Assign multiple tasks to employee*******************
	def tl_assign_to_multiple
		authorize! :update, Task
		# **********************if both devlopers an testers are selected************
		if(params[:developer] != ""  and params[:tester] != "" )	
			flash[:notice] =  "You cannot select both developer and tester "
			redirect_to make_task_tl_path(@rq.id)
		else
			# *********If developer is selected ********************
			if (params[:developer] != "" && params[:tasks_ids] != nil)
							
				Task.where(id: params[:tasks_ids]).update_all developer_id:   params[:developer]
				Task.where(id: params[:tasks_ids]).update_all status_id: 1
	    		redirect_to make_task_tl_path(@rq.id)
	    		#==notifications
			      @user= params[:developer]
			      str="some tasks are assigned to you by TL: #{current_user.username}."
			      @n=Notification.create(:notice => str, :user_id => @user)
			      @n.save!


	    	# ********If tester is selected ************************
	    	elsif(params[:tester] != "" && params[:tasks_ids] != nil)
	    		Task.where(id: params[:tasks_ids]).update_all tester_id: params[:tester]
	    		Task.where(id: params[:tasks_ids]).update_all status_id: 3
	    		redirect_to make_task_tl_path(@rq.id)
	    		#==notifications
			      @user= params[:tester]
			      str="some tasks are assigned to you by TL: #{current_user.username}."
			      @n=Notification.create(:notice => str, :user_id => @user)
			      @n.save!

	    	# If no task is selected or no employee is selected
			else 
				flash[:notice] =  "You Didn't selected any employee or task"
				redirect_to make_task_tl_path(@rq.id)
			end
		end
	end

	# ************************Assign Tasks ****************************
	def tl_assign
		authorize! :update, Task
		# **********************if both devlopers an testers are selected************
		if(params[:developer] != nil and params[:tester] != nil)	
			flash[:notice] =  "You cannot select both developer and tester "
			redirect_to make_task_tl_path(@rq.id)
		
		else
			# *********If developer is selected ********************
			if (params[:developer] != nil )							
				Task.where(id: params[:tasks_ids]).update_all developer_id:   params[:developer]
				Task.where(id: params[:tasks_ids]).update_all status_id: 1
	    		redirect_to make_task_tl_path(@rq.id)
	    		#==notifications
			      @user= params[:developer]
			      str="some tasks are assigned to you by TL: #{current_user.username}."
			      @n=Notification.create(:notice => str, :user_id => @user)
			      @n.save!

			# ********If tester is selected ************************
	    	elsif(params[:tester] != nil )
	    		Task.where(id: params[:tasks_ids]).update_all tester_id: params[:tester]
	    		Task.where(id: params[:tasks_ids]).update_all status_id: 3
	    		redirect_to make_task_tl_path(@rq.id)
	    		#==notifications
			      @user= params[:tester]
			      str="some tasks are assigned to you by TL: #{current_user.username}."
			      @n=Notification.create(:notice => str, :user_id => @user)
			      @n.save!
			# If no task is selected or no employee is selected	    	
			else 
				flash[:notice] =  "You Didn't selected any employee or task"
				redirect_to make_task_tl_path(@rq.id)
			end
		end
	end
	
	#********************************Add task to requirement ***********************
	def add_task
		authorize! :create, Task
		@tasktype= Tasktype.all
		@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
		@tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
		@task= Task.new
	end

	# ****************************All developers under this TL**************************
	def developer
		authorize! :read, User
		@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
	end

	# ****************************All testers under this TL**************************
	def tester
		authorize! :read, User
		@tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
	end

	# ****************************Find requirement**************************
  	def find_requirement
  		@rq = Requirement.find(params[:id])
 	end

	
end
