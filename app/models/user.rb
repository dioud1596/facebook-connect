class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
                  
  has_many :authentications, dependent: :destroy
    
  def apply_facebook(fb_infos)
    
    self.email = fb_infos[:email] if self.email.blank?
    self.facebook_id = fb_infos[:facebook_id]
    self.user_name = fb_infos[:user_name] if self.user_name.blank? 
    self.picture_url = 'https://graph.facebook.com/'+ fb_infos[:facebook_id] +'/picture'     
      
    self.authentications.build(
      :provider => fb_infos[:provider],
      :token => fb_infos[:token],
      :token_expiry => fb_infos[:token_expiry]
    )
    
  end  
  
  def fb_token
    authentications.find_by_provider("facebook").token
  end
    
  
  def has_fb_authentication?
    !authentications.find_by_provider("facebook").nil?
  end
    
end
