class ApplicationController < ActionController::Base
    
  include SessionsHelper
  
# 例外処理
rescue_from ActiveRecord::RecordNotFound, with: :render_404
rescue_from ActionController::RoutingError, with: :render_404
rescue_from Exception, with: :render_500  

def render_404
  redirect_to root_url
end

def render_500
  redirect_to root_url
end
    
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end   
  
  def counts(user)
    @count_posts = user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count 
    @count_likes = user.likes.count
  end  
end
