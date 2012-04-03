class UsersController < ApplicationController

def index
  @services = current_user.services.order('provider asc')
end

def destroy
  # remove an authentication service linked to the current user
  @service = current_user.services.find(params[:id])
  
  if session[:service_id] == @service.id
    flash[:error] = 'You are currently signed in with this account!'
  else
    @service.destroy
  end
  
  redirect_to services_path
end

def signout 
  if current_user
    session[:user_id] = nil
    session[:service_id] = nil
    session.delete :user_id
    session.delete :service_id
    flash[:notice] = 'You have been signed out!'
  end  
  redirect_to root_url
end

def failure
  flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
  redirect_to root_url
end


end
