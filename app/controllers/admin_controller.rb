class AdminController < ApplicationController

  before_action() { authorize! :create, Teamlead }
	
	def teamlead 
    @tls= Teamlead.where("user_id = ?",current_user.id).order("created_at DESC") #Return Team Leads
	end

	def developer
		@ds= User.where(:usertype_id => 3)   #Return developers
	end

	def tester 
		@ts= User.where(:usertype_id => 4) #Return testers
  end

	def make_teamlead
		@user = User.find(params[:id])
  	@user.usertype_id = 2                 #Make Team Lead; Usertype 2 means Team lead
  	@user.teamlead_id = current_user.id
  	@user.save

  	@t=Teamlead.create(:username => @user.username, :user_id => current_user.id) # Create Team lead in table
  	@t.save
    
      # notifications***********
      @tl=@user
      str="Admin: #{current_user.username} made you Team Leader."
      @n=Notification.create(:notice => str, :user_id => @tl.id)
      @n.save!

      str="You made #{@user.username} a Team Lead."
      @n=Notification.create(:notice => str, :user_id => current_user.id)
      @n.save!
      #************
      
		redirect_to 'admin/teamlead'
	end
	
  # Show page - of editing multiple selected projects**********
  def edit_project_multiple
    @tl   = Teamlead.where("user_id = ?",current_user.id) 
  	if params[:project_ids] == nil
  		flash[:notice] =  "You Didn't selected any project"
  		redirect_to root_path
  	else
    	@rqs = Requirement.find(params[:project_ids])  
	  end
  end
  #*******************

  # Updating multiple selected projects *****************
  def update_project_multiple   
    @rqs = Requirement.update(params[:projects].keys, params[:projects].values)
 		redirect_to root_path
  end
  #*********************

  # Show page - Assigning employees which are not assigned to any team leader********************
  def assign_employee
    @tl= Teamlead.find(params[:id])
  	@employees= User.where("teamlead_id == ? and usertype_id!=? and usertype_id!=?", 1,1,2).order("usertype_id") #All unassigned employees	 
    @this_employees= User.where("teamlead_id == ?", @tl).order("usertype_id")           #Employees under current team leader
  end
  #****************************

  # Put request - Assigning employees which are not assigned to any team leader*******************
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
      #***
  	redirect_to assign_employee_path(params[:tid])
  end
  #******************************
end

