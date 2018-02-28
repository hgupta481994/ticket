class TaskController < ApplicationController

	before_action :find_task, only: [:show, :edit, :update, :destroy]

	
 	
	def index
  		@tks= Taskall.order("created_at DESC") 
  	end


	def create
    	@tk = Task.new(task_params)
    	
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
  	
  	if @rq.update_attributes(task_params)
  		redirect_to(:action =>'show', :id => @rq.id)
  	else
  		render 'task/edit'
  	end
  end

  def destroy
  	@rq.destroy
  	redirect_to 'root'
  end



  

  def find_task
  	@rq = Task.find(params[:id])
  end

  private 
    def task_params 
    	 params.require(:task).permit(:name,:description,:avatar,:start,:end, :teamlead_id, :tasktype_id, :requirement_id, :user_id)
end
end
