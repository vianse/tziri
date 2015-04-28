class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
def index
  	@name = Profile.where(:user_id => current_user.id).count
  	if @name != 0 
     @mensaje = "Lo sentimos, el código ingresado no es valido, favor de ingresar un código valido."
    else
     redirect_to :controller => 'profiles', :action => 'new'
    
    end
  end
end
