class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
                  
  has_many :authentications, dependent: :destroy
    
  def apply_facebook(omniauth)
    
    if (extra = omniauth['extra']['raw_info'] rescue false)
      self.email = omniauth['extra']['raw_info']['email'] if self.email.blank?
      self.facebook_id = omniauth['uid']
      self.user_name = omniauth['extra']['raw_info']['username'] if self.user_name.blank? 
      self.picture_url = 'https://graph.facebook.com/'+ omniauth['uid'] +'/picture'     
    end 
      
    self.authentications.build(
      :provider => omniauth['provider'],
      :token => (omniauth['credentials']['token'] rescue nil),
      :token_expiry => (omniauth['credentials']['expires_at'].to_i rescue nil)
    )
    
  end
    
  
  def has_fb_authentication?
    !authentications.find_by_provider("facebook").nil?
  end
    
end
