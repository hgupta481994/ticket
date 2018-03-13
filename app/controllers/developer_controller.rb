class DeveloperController < ApplicationController
	
	def done_multiple_update
	 	@tasks= Task.where(id: params[:tasks_ids])
		@tasks.each do |t|
			if t.status_id == 1
				t.status_id = 2
			elsif t.status_id == 2
				t.status_id = 1
			end
			t.save
		end 
    	redirect_to root_path
	end 

end
