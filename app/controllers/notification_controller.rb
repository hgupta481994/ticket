class NotificationController < ApplicationController
	before_action :find_notice, only: [:show, :destroy]
	def destroy
	  	@n.destroy
	    redirect_to '/notification'
	end

  	def find_notice
  		@n = Notification.find(params[:id])
  	end

  	def delete_all
  		Notification.where(:user_id => params[:id]).delete_all
  		redirect_to '/notification'
  	end
end
