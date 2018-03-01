class RequirementController < ApplicationController

	before_action :find_requirement, only: [:show, :showa,:edit, :update, :destroy]
 	
	def index
  		@rqs= Requirement.all.order("created_at DESC") 
  	end

 	def new
  		@rq= current_user.requirements.build
 	end

	def create
    	@rq = current_user.requirements.build(requirement_params)
    	if @rq.save
	      flash[:notice] = "Project successfully created"
	        
	      redirect_to '/home'
	    else
	      render 'requirement/new'
	    end
	end 
  def showa
   
    @dps = User.where("teamlead_id = ? and usertype_id = 3", @rq.teamlead_id)
    @tts = User.where("teamlead_id = ? and usertype_id = 4", @rq.teamlead_id)
  end

  def show
    @dps = User.where("teamlead_id = ? and usertype_id = 3", Teamlead.find_by_username(current_user.username).id)
    @tts = User.where("teamlead_id = ? and usertype_id = 4", Teamlead.find_by_username(current_user.username).id)
  end 

  def edit
  	
  end 

  def update
  	
  	if @rq.update_attributes(requirement_params)
  		redirect_to(:action =>'show', :id => @rq.id)
  	else
  		render 'requirement/edit'
  	end
  end

  def destroy
  	@rq.destroy
  	redirect_to 'root'
  end



  

  def find_requirement
  	@rq = Requirement.find(params[:id])
  end

  private 
    def requirement_params 
    	 params.require(:requirement).permit(:name,:description,:avatar,:end, :teamlead_id) 
  	end
end