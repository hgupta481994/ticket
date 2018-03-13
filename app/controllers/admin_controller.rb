class AdminController < ApplicationController
	
	def teamlead
		@tls= Teamlead.all.order("created_at DESC")
	end

	def developer
		@ds= User.where(:usertype_id => 3)
	end

	def tester
		@ts= User.where(:usertype_id => 4)
	end

	def make_teamlead
		authorize! :create, Teamlead
		@user = User.find(params[:id])
      	@user.usertype_id = 2
      	
      	@user.save
      	@t=Teamlead.create(:username => @user.username)
      	@t.save
		redirect_to 'admin/teamlead'
	end
	
  def edit_project_multiple
  	if params[:project_ids] == nil
  		flash[:notice] =  "You Didn't selected any project"

  		redirect_to root_path
  	else
    	@rqs = Requirement.find(params[:project_ids])  
	end
  end

  def update_project_multiple  
    @rqs = Requirement.update(params[:projects].keys, params[:projects].values)
 		redirect_to root_path
  end

  def assign_employee
  	@employees= User.order("usertype_id")
	@tl= Teamlead.find(params[:id])
  end

  def assign_employee_put
  	@uassign = User.where(id: params[:employee_ids]).update_all teamlead_id: params[:tid]
  	redirect_to assign_employee_path(params[:tid])
  end
end

