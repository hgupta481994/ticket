class TesterController < ApplicationController
	before_action() { authorize! :access, :tester }
	def done_multiple_update
		authorize! :update , Task
	 	@tasks= Task.where(id: params[:tasks_ids])
		@tasks.each do |t|
			if t.status_id == 3
				t.status_id = 4
				@tl=User.find_by_username(Teamlead.find(t.teamlead_id).username).id
				str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been reviewed by Tester: #{current_user.username}"
				@n=Notification.create(:notice => str, :user_id => @tl)
				@n.save!

				str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been reviewed by you"
				@n=Notification.create(:notice => str, :user_id => current_user.id)
				@n.save!
				flash[:notice] = str

			elsif t.status_id == 4
				t.status_id = 3
				@tl=User.find_by_username(Teamlead.find(t.teamlead_id).username).id
				str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been reverted by Tester: #{current_user.username}"
				@n=Notification.create(:notice => str, :user_id => @tl)
				@n.save!

				str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been reverted by you"
				@n=Notification.create(:notice => str, :user_id => current_user.id)
				@n.save!
				flash[:notice] = str
				
			end
			t.save
		end 
    	redirect_to root_path
	end 
end
