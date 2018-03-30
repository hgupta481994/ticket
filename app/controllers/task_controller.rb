class TaskController < ApplicationController
  load_and_authorize_resource
	before_action :find_task, only: [:show, :edit, :update, :destroy, :reopen_task]

	
 	
	def index
  		@tks= Task.all.order("created_at DESC") 
  	end


	def create
    	@tk = Task.new(task_params)
      @rq= Requirement.find(@tk.requirement_id)
      if @tk.developer_id != nil
        @tk.status_id = 1
        if @rq.users.where(:id => @tk.developer_id).empty?
          @rq.users << User.find(@tk.developer_id)
        end
      else
        @tk.developer_id = @tk.teamlead_id
    	end

      if @tk.tester_id == nil
         @tk.tester_id = @tk.teamlead_id
      else
        if @rq.users.where(:id => @tk.tester_id).empty?
          @rq.users << User.find(@tk.tester_id)
        end
      end
     
    	if @tk.save!
    		flash[:notice] = "Task successfully created"
        # notifications
        
        str="New Task: '#{@tk.name}' is assigned to you"
        if @tk.developer_id != @tk.teamlead_id 
          @n=Notification.create(:notice => str, :user_id => @tk.developer_id)
          @n.save!
        end
        if @tk.tester_id != @tk.teamlead_id 
          @n=Notification.create(:notice => str, :user_id => @tk.tester_id)
          @n.save!
        end
	        redirect_to make_task_tl_path(@tk.requirement_id)
	    else	    	
	    	flash[:notice] = "Task not created"
	      redirect_to make_task_tl_path(@tk.requirement_id)
	    end
	end 

  def show
    if current_user.is_tlead?
    	@dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
      @tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id).order("updated_at DESC")
    end
  end 

  def edit
  	
  end 

  def update
  	
  	if @tk.update_attributes(task_params)
  		redirect_to(:action =>'show', :id => @tk.id)
  	else
  		render 'task/edit'
  	end
  end

  def destroy
  	@tk.destroy

    #==notifications
    @tl=User.find_by_username(current_user.username).id
    #For Admin
    str="Task no #{@tk.id}  of Project #{Requirement.find(@tk.requirement_id).name} has been deleted by you."
    @n=Notification.create(:notice => str, :user_id => @tl)
    @n.save!

    @rid= @tk.requirement_id
    redirect_to requirement_path(@rid)
  end

  def close_task
    
    @tks=Task.where(id: params[:id]).update status_id: 5
    @tks.each do |t|

      #==notifications
      @tl=User.find_by_username(current_user.username)
      #For teamlead
      str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been closed by you."
      @n=Notification.create(:notice => str, :user_id => @tl.id)
      @n.save!
      #For admin
      str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been closed by Team Lead: #{current_user.username}."
      @n=Notification.create(:notice => str, :user_id => User.find(@tl.teamlead_id).id)
      @n.save!
    end
      
    flash[:notice] =  "Task successfully closed "
    redirect_to task_path(params[:id])
    #
  end

  def reopen_task
    authorize! :update , Task
    if @tk.status_id == 5

      #==notifications
      Task.where(id: params[:id]).update status_id: 6
      @tl=User.find_by_username(Teamlead.find(@tk.teamlead_id).username).id
      #For teamlead
      str="Task no #{@tk.id}  of Project #{Requirement.find(@tk.requirement_id).name} has been reopened by Admin: #{current_user.username}."
      @n=Notification.create(:notice => str, :user_id => @tl)
      @n.save!
      #For admin
      str="Task no #{@tk.id}  of Project #{Requirement.find(@tk.requirement_id).name} has been reopened by you."
      @n=Notification.create(:notice => str, :user_id => current_user.id)
      @n.save!
      flash[:notice] =  "Task successfully reopened "
      redirect_to requirement_path(@tk.requirement_id)
    else
      flash[:notice] =  "Task is not closed "
      redirect_to requirement_path(@tk.requirement_id)
    end
  end
  

  def find_task
  	@tk = Task.find(params[:id])
  end

  private 
    def task_params 
    	 params.require(:task).permit(:name,:description,:avatar,:start,:end, :teamlead_id, :tasktype_id, :requirement_id, :developer_id, :tester_id)
end
end
