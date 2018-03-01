class AdminController < ApplicationController
	
	def teamlead
		@tls= Teamlead.all.order("created_at DESC")
	end

	def developer
		@ds= User.where(:usertype_id => 3)
	end

	def tester
		@ts= User.where(:usertype_id => 4)
	end

	def make_teamlead
		
		@user = User.find(params[:id])
      	@user.usertype_id = 2
      	
      	@user.save
      	@t=Teamlead.create(:username => @user.username)
      	@t.save
		redirect_to 'admin/teamlead'
	end

	
end

