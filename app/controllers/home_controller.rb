class HomeController < ApplicationController
  def index
  	@name = Profile.where(:user_id => current_user.id).count
  	if @name != 0 
     @mensaje = "Lo sentimos, el código ingresado no es valido, favor de ingresar un código valido."
    else
     redirect_to :controller => 'profiles', :action => 'new'
    
    end
  end
end
