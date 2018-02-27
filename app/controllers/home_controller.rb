class HomeController < ApplicationController
  def index
  	@tasks= Task.all.order("created_at DESC")
  	@rqs= Requirement.all.order("created_at DESC")
  end
end
