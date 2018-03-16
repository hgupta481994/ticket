class TaskController < ApplicationController
  load_and_authorize_resource
	before_action :find_task, only: [:show, :edit, :update, :destroy, :reopen_task]

	
 	
	def index
  		@tks= Taskall.order("created_at DESC") 
  	end


	def create
    	@tk = Task.new(task_params)
      if @tk.user_id != nil
        @tk.status_id = 1
    	end
    	if @tk.save
    		flash[:notice] = "Task successfully created"
	        redirect_to make_task_tl_path(@tk.requirement_id)
	    else
	    	
	    	flash[:notice] = "Task not created"
	      	redirect_to make_task_tl_path(@tk.requirement_id)
	    end
	end 

  def show
  	
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
      @tl=User.find_by_username(current_user.username).id
      str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been closed by you."
      @n=Notification.create(:notice => str, :user_id => @tl)
      @n.save!

      str="Task no #{t.id}  of Project #{Requirement.find(t.requirement_id).name} has been closed by Team Lead: #{current_user.username}."
      @n=Notification.create(:notice => str, :user_id => User.find_by_usertype_id( 1).id)
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
      str="Task no #{@tk.id}  of Project #{Requirement.find(@tk.requirement_id).name} has been reopened by Admin: #{current_user.username}."
      @n=Notification.create(:notice => str, :user_id => @tl)
      @n.save!

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
    	 params.require(:task).permit(:name,:description,:avatar,:start,:end, :teamlead_id, :tasktype_id, :requirement_id, :user_id)
end
end
