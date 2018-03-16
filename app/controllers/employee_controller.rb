class EmployeeController < ApplicationController
	
	before_action :find_employee, only: [ :destroy]
	
	def find_employee
  		@employee = User.find(params[:id])
  	end

	def destroy
		authorize! :update, Task
		@task=Task.find_by_user_id(@employee.id)
		if @task != nil
			@task.update_attribute(:user_id, @task.teamlead_id)
		end 
  		@employee.destroy
  		redirect_to root_path
	end
end
