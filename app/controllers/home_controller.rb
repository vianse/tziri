class HomeController < ApplicationController
  def index
  	@name = Profile.where(:user_id => current_user.id).count
  	if @name != 0 
    
    else
     redirect_to :controller => 'profiles', :action => 'new'
    
    end
  end
end
