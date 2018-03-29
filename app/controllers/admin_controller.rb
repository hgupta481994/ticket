class AdminController < ApplicationController

  before_action() { authorize! :create, Teamlead }
  before_action :find_team_leads, only: [:teamlead , :edit_project_multiple,]
	
	def teamlead 
    #Return Team Leads
	end

	def developer
    # Return developer who are under teamleads of this manager and also who are not assigned
		@ds = User.where(:teamlead_id => User.where("teamlead_id = ? or id = 1",current_user.id), :usertype_id => 3).order("updated_at DESC")   
	end

	def tester 
    # Return tester who are under teamleads of this manager and also who are not assigned
		@ts = User.where(:teamlead_id => User.where("teamlead_id = ? or id = 1",current_user.id), :usertype_id => 4).order("updated_at DESC").order("updated_at DESC") 
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
    
  	if params[:project_ids] == nil
  		flash[:notice] =  "You Didn't selected any project"
  		redirect_to root_path
  	else
    	@rqs = Requirement.where(params[:project_ids])  
	  end
  end
  #*******************

  # Updating multiple selected projects *****************
  def update_project_multiple   
    @rqs = Requirement.update(params[:projects].keys, params[:projects].values)
    # notifications***********
    @rqs.each do |r|
      @tl=r.teamlead_id
      str= "Admin: #{current_user.username} edited this project."
      @n=Notification.create(:notice => str, :user_id => @tl.id)
      @n.save!
    end
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
      @tl= Teamlead.find( params[:tid])
      # To team Leader
      str="Admin: #{current_user.username} assigned employees to you."
      @n=Notification.create(:notice => str, :user_id => @tl.id)
      @n.save!
       # To admin
      str="You assigned employees to Team Lead: #{@tl.username}"
      @n=Notification.create(:notice => str, :user_id => current_user.id)
      @n.save!
      #***
       # To employees 
      @emp=params[:employee_ids]
      @emp.each do |u|
        str="You are assigned to Tl: #{@tl.username} by Admin: #{current_user.username}."
        @n=Notification.create(:notice => str, :user_id => u)
        @n.save!
      end
  	redirect_to assign_employee_path(params[:tid])
  end
  #******************************

  def find_team_leads
    @tls   = Teamlead.where("user_id = ?",current_user.id).order("created_at DESC") #Return Team Leads
  end
end

