class DeveloperController < ApplicationController
	before_action() { authorize! :access, :developer}
	def done_multiple_update
		authorize! :update , Task
	 	@tasks= Task.where(id: params[:tasks_ids])
		@tasks.each do |t|
			if t.status_id == 1
				if t.tester_id != t.teamlead_id 
					t.status_id = 3
				else
					t.status_id = 2
				end
				#*****Motifications
				@tl=User.find_by_username(Teamlead.find(t.teamlead_id).username)
				# For teamlead
				str="Task name: '#{t.name}' of Project: '#{Requirement.find(t.requirement_id).name}' has been done by Developer: #{current_user.username}"
				@n=Notification.create(:notice => str, :user_id => @tl.id)
				@n.save
				# For developer
				str="Task name: '#{t.name}' of Project: '#{Requirement.find(t.requirement_id).name}' has been done by you"
				@n=Notification.create(:notice => str, :user_id => current_user.id)
				@n.save!
				#For Tester
				if t.tester_id != t.teamlead_id 
					str="Start review of Task: '#{t.name}'  of Project: '#{Requirement.find(t.requirement_id).name}'"
					@n=Notification.create(:notice => str, :user_id => t.tester_id)
					@n.save	
				end
				flash[:notice] = str
			elsif t.status_id == 2
				t.status_id = 1
				@tl=User.find_by_username(Teamlead.find(t.teamlead_id).username).id
				# For teamlead
				str= "Task name: '#{t.name}' of Project: '#{Requirement.find(t.requirement_id).name}' has been reverted by Developer: #{current_user.username}"
				@n=Notification.create(:notice => str, :user_id => @tl)
				@n.save
				# For developer
				str="Task name: '#{t.name}' of Project: '#{Requirement.find(t.requirement_id).name}' has been reverted by you"
				@n=Notification.create(:notice => str, :user_id => current_user.id)
				@n.save!
				flash[:notice] = str
			end
			t.save
		end 
    	redirect_to root_path
	end 

end
