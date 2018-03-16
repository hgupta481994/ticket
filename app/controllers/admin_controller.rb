class AdminController < ApplicationController

  before_action() { authorize! :create, Teamlead }
	
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
		
		@user = User.find(params[:id])
      	@user.usertype_id = 2
      	
      	@user.save
      	@t=Teamlead.create(:username => @user.username)
      	@t.save
        
          #==notifications
          @tl=@user
          str="Admin: #{current_user.username} made you Team Leader."
          @n=Notification.create(:notice => str, :user_id => @tl.id)
          @n.save!

          str="You made #{@user.username} a Team Lead."
          @n=Notification.create(:notice => str, :user_id => current_user.id)
          @n.save!

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

       #==notifications
      @tl= params[:tid]
      str="Admin: #{current_user.username} assigned employees to you."
      @n=Notification.create(:notice => str, :user_id => @tl)
      @n.save!

      str="You assigned employees to Team Lead: #{@user.username}"
      @n=Notification.create(:notice => str, :user_id => current_user.id)
      @n.save!

  	redirect_to assign_employee_path(params[:tid])
  end
end

