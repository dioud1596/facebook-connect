OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  provider :facebook, "1410945925828897", "589ae1ff4bbccea4996960946ce40f5c"
end