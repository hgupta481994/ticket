class HomeController < ApplicationController
	
  def index
    if current_user.present?
      if current_user.usertype_id ==1
    	 @rqs= current_user.requirements.order("created_at DESC")
      elsif current_user.usertype_id == 2
        @rqs=Requirement.where("teamlead_id = ?", Teamlead.find_by_username(current_user.username).id )
      else
        @tks= Task.where(:user_id => current_user )
      end
    end
  end

  def notification
  	@notices= current_user.notifications.order("created_at DESC")
  end

  def delete_notice
  	Notification.where(:id => params[:notice_ids]).destroy_all
  	redirect_to '/notification'
  end
end
