class HomeController < ApplicationController
	
  def index
  	@tasks= Task.all.order("created_at DESC")
  	@rqs= Requirement.all.order("created_at DESC")
  	@tks= Task.where(:user_id => current_user )
  end

  def notification
  	@notices= current_user.notifications.order("created_at DESC")
    
    
  end

  def delete_notice
  	Notification.where(:id => params[:notice_ids]).destroy_all
  	redirect_to '/notification'
  end
end
