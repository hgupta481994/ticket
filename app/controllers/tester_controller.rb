class TesterController < ApplicationController
	def done_multiple_update
	 	@tasks= Task.where(id: params[:tasks_ids])
		@tasks.each do |t|
			if t.status_id == 3
				t.status_id = 4
			elsif t.status_id == 4
				t.status_id = 3
			end
			t.save
		end 
    	redirect_to root_path
	end 
end
