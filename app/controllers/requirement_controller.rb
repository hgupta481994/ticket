class RequirementController < ApplicationController
  load_and_authorize_resource

	before_action :find_requirement, only: [:show, :showa,:edit, :update, :destroy]
  before_action :find_all_tl, only: [:new, :edit]

  # *****************************************new requirement********************
 	def new
  		@rq= current_user.requirements.build
 	end
  
	def create
    	@rq = current_user.requirements.build(requirement_params) # Build requirement for current user
    	if @rq.save!
        current_user.requirements << @rq # push in join table of requirement and user

	      flash[:notice] = "Project successfully created"
	        
	      redirect_to root_path
	    else
	      render 'requirement/new'
	    end
	end 
 

  # *****************************************Show page of requirement********************
  def show
    authorize! :show, Requirement
    
    @dp_tks = Task.where("requirement_id == ?  and (status_id is null or status_id == 1 or status_id==6)", params[:id])
    @tt_tks = Task.where("requirement_id == ?  and (status_id == 2 or status_id==3)", params[:id])
    # For admin
    @a_tks  = Task.where(:requirement_id => params[:id]).order("status_id") 
    if @rq.teamlead_id != nil
      @tl  = Teamlead.find(@rq.teamlead_id)
    end
    @dps = User.where("teamlead_id = ? and usertype_id = 3",  @rq.teamlead_id) #All developers of project 
    @tts = User.where("teamlead_id = ? and usertype_id = 4",  @rq.teamlead_id) #All testers of project
  end 

  # *****************************************update requirement********************
  def edit 
  end 

  def update	
  	if @rq.update_attributes(requirement_params)
  		redirect_to(:action =>'show', :id => @rq.id)
  	else
  		render 'requirement/edit'
  	end
  end

  # *****************************************delete requirement********************
  def destroy
  	@rq.destroy

    #==Notifications
    @tl=User.find(current_user.id).id
    str="Project: #{@rq.name} has been deleted by you."
    @n=Notification.create(:notice => str, :user_id => @tl)
    @n.save!
    
  	redirect_to root_path
  end

  # ******************* Find requirement in table by its id *********************
  def find_requirement
  	@rq = Requirement.find(params[:id])
  end
  # ******************* Find Team leaders of current admin/manager ****************
  def find_all_tl
     @tl   = Teamlead.where("id != ? and user_id == ?",1, current_user.id) 
  end
  # ******************* Permitted parameters ****************
  private 
    def requirement_params 
    	 params.require(:requirement).permit(:name,:description,:end, :teamlead_id,:avatar) 
  	end
end