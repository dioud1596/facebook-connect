class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def create
        
    omniauth = request.env["omniauth.auth"]
    fb_infos = parse_fb_from(omniauth)
    
    # looking for a user having already signed up with fb
    user = current_user || User.find_by_email(fb_infos[:email])    
    
    if user # we find him 
      user.apply_facebook(fb_infos) unless user.has_fb_authentication?
      flash[:notice] = "Signed in successfully."
      user.save
      sign_in_and_redirect(user)    
       
    else # first signup with fb
      user = User.new
      session[:fb_infos] = fb_infos
      redirect_to new_user_registration_url
    end
    
  end
  
  
  private
  
  def parse_fb_from(omniauth)
    
    fb_infos = {}
    
    fb_infos[:email] = omniauth['extra']['raw_info']['email'] 
    fb_infos[:user_name]  = omniauth['extra']['raw_info']['username'] 
    fb_infos[:facebook_id] = omniauth['uid']
    fb_infos[:provider]  = omniauth['provider'] 
    fb_infos[:token]  = omniauth['credentials']['token'] rescue nil
    fb_infos[:token_expiry]  = omniauth['credentials']['expires_at'] rescue nil
    
    fb_infos
         
  end
  
  
end


