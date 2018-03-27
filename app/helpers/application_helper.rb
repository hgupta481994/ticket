module ApplicationHelper

	def count_function()
	    if current_user.present?
	      @count = Notification.where(:user_id => current_user.id, :checked => false.to_s).count
	    end
  end

end
