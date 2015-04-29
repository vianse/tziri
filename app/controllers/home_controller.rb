class HomeController < ApplicationController
  def index
  	@name = Profile.where(:user_id.to_s => current_user.id.to_s).count
  	if @name != 0 
     @mensaje = "Lo sentimos, el código ingresado no es valido, favor de ingresar un código valido."
    else
     redirect_to :controller => 'profiles', :action => 'new'
    
    end
  end
end
