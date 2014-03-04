class HomeController < ApplicationController
  def welcome
    
    if current_user.has_fb_authentication?
      graph = Koala::Facebook::API.new(current_user.fb_token)
      @profile = graph.get_object("me")
      @friends = graph.get_connections("me", "friends")  
    end
    
  end
end
