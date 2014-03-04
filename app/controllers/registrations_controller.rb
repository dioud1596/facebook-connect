class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:fb_infos] = nil unless @user.new_record?
  end
  
  private
  
  def build_resource(*args)
    super
    if session[:fb_infos]
      @user.apply_facebook(session[:fb_infos])
      @user.valid?
    end
  end
  
end