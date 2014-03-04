class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def create
        
    omniauth = request.env["omniauth.auth"]
    
    # looking for a user having already signed up with fb
    user = current_user || User.find_by_email(omniauth['extra']['raw_info']['email'])    
    
    if user # we find him 
      user.apply_facebook(omniauth) unless user.has_fb_authentication?
      flash[:notice] = "Signed in successfully."
      user.save
      sign_in_and_redirect(user)    
       
    else # first signup with fb
      user = User.new
      session[:omniauth] = omniauth
      redirect_to new_user_registration_url
    end
    
  end
end


