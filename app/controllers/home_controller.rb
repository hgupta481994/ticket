class HomeController < ApplicationController
	
  def index
  	@tasks= Task.all.order("created_at DESC")
  	@rqs= Requirement.all.order("created_at DESC")
  	@tks= Task.where(:user_id => current_user )
  end
end
